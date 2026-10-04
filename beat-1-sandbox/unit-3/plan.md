# Plan: fix #53, PII scrubber does not redact parenthesized US phone numbers

Issue: https://github.com/codepath/pathreview-ai301-fa26-s3/issues/53
Builds on my repro comment: https://github.com/codepath/pathreview-ai301-fa26-s3/issues/53#issuecomment-5859599202

## Diagnosis

The cause is the `phone_us` pattern in `safety/pii_scrubber.py` (line 16):

```
\b(?:\+?1[-.]?)?\(?([0-9]{3})\)?[-.]?([0-9]{3})[-.]?([0-9]{4})\b
```

My repro comment identified the space after `)`. Checking further since then, the pattern has two defects:

1. **Separators allow only `-` or `.`.** A space after `)` (as in `(555) 123-4567`) or between digit groups (as in `+1 555 123 4567`) cannot match.
2. **The leading `\b` cannot sit directly before `(`.** When the number starts with `(` after a space or at a line start, there is no word boundary there, so the match starts at `555` and the `(` is never consumed.

Repro evidence this relies on (outputs I captured on `main` before any change):

- `python repro.py`:
  `scrub(): Call me at (555) 123-4567 or [REDACTED]`
  `detect(): [{'type': 'phone_us', 'value': '555-123-4567', 'start': 29, 'end': 41}]`
  The parenthesized number is neither redacted nor detected; only the dashed one is.
- Direct `scrub()` calls:
  `'Contact: (555) 123-4567' -> 'Contact: (555) 123-4567'` (defect 1)
  `'Contact: (555)123-4567' -> 'Contact: ([REDACTED]'` (defect 2: with no space the number is redacted but the `(` is left behind)
  `'Contact: +1 555 123 4567' -> 'Contact: +1 555 123 4567'` (defect 1, a format listed in `test_us_phone_formats`)
- `python -m pytest tests/unit/test_pii_scrubber.py -q`: `20 passed, 5 xfailed`.

`scrub()` and `detect()` both loop over `PII_PATTERNS`, so one pattern change fixes both.

## Scope

In scope, one bounded change:

- Change the `phone_us` pattern in `safety/pii_scrubber.py` so spaces are accepted as separators and the leading `\b` is replaced with a lookbehind that allows a leading `(`.
- In `tests/unit/test_pii_scrubber.py`, remove the `@pytest.mark.xfail` marker from the four tests the issue lists: `test_us_phone_number_redaction`, `test_us_phone_formats`, `test_detect_phone_pii`, `test_phone_at_start_of_text`. The markers are `strict=True`, so `docs/CONTRIBUTING.md` requires removing them once the fix makes these tests pass.
- Add one regression test for `(555)123-4567` (no space), asserting no stray `(` is left. No existing test covers defect 2.

Out of scope, and why:

- The `street_address` pattern. It over-matches: `scrub("I worked at TechCorp for 5 years developing Python applications.")` returns `'I worked at TechCorp for [REDACTED]ications.'` because `Pl` inside `applications` matches. This is why `test_mixed_pii_and_text` fails even though its marker cites #53. That marker stays as it is, since removing it would turn CI red. Correction to my repro comment: there I grouped this test with the phone gap because it is marked #53; on closer inspection it fails for this other reason.
- The `phone_intl`, `email` and `ssn` patterns, the logging in `detect()`, and the existing `# noqa: B007`.
- Any lint or type cleanup (no `ruff --fix`).

## Files to touch

- `safety/pii_scrubber.py`: the `phone_us` entry of `PII_PATTERNS` only.
- `tests/unit/test_pii_scrubber.py`: remove four `xfail` decorators, add one test.

## Approach

1. Create branch `fix/53-phone-parenthesized-format` from `main`.
2. Replace the `phone_us` pattern with:
   ```
   (?<!\w)(?:\+?1[-. ]?)?\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\b
   ```
   For inputs starting with a digit the lookbehind behaves like the old `\b`; the difference is that a leading `(` is now consumed.
3. Remove the four `xfail` decorators and add the regression test.
4. Run the new tests and the repro, then `make lint`, `make format`, `make typecheck`, `make test-unit`.
5. Commit as `fix(safety): redact parenthesized and space-separated US phone numbers` with `Fixes #53` in the body.

## Test plan

I re-run the same steps I used for the repro and compare with the outputs quoted above.

1. `python repro.py`. Before: only `555-123-4567` is redacted. After: `scrub()` prints `Call me at [REDACTED] or [REDACTED]`, and `detect()` lists two `phone_us` entries, one with value `(555) 123-4567`.
2. Direct `scrub()` calls. After: `'Contact: (555) 123-4567'`, `'Contact: (555)123-4567'` and `'Contact: +1 555 123 4567'` each become `'Contact: [REDACTED]'`, with no leftover `(`.
3. `python -m pytest tests/unit/test_pii_scrubber.py -q`. Before: `20 passed, 5 xfailed`. After: `25 passed, 1 xfailed`, where the one xfail is `test_mixed_pii_and_text`.
4. False-positive check. `scrub("Total 100 200 3000 items")` returns the text unchanged today. I will record what it returns after the change (see risks).

## Risks and unknowns

- Accepting spaces as separators may redact other groups of ten digits written with spaces. In a standalone copy of the regex, `Total 100 200 3000 items` was redacted; I have not yet confirmed this in the repo, and I do not know whether the maintainers consider it acceptable.
- I am assuming spaces should be accepted in every separator position because `test_us_phone_formats` lists `+1 555 123 4567`; I have not confirmed the intended format list with a maintainer.
- I traced `test_mixed_pii_and_text` to the `street_address` pattern in a standalone copy and with one direct `scrub()` call, but I have not run that test against a fix, so I do not know whether another cause also contributes to its failure.
- PR #77 (open, by another contributor) already targets this issue and also changes `street_address`, so a PR from this plan may overlap or conflict with it; I do not know which approach the maintainers prefer.
- I have not checked whether `pyproject.toml` carries a suppression tied to #53, and I will not run the `integration` and `frontend` CI jobs locally.

## Deviations

- Built as planned: one change to the phone_us pattern, four xfail markers removed, and one regression test added; the test file went from 20 passed, 5 xfailed to 25 passed, 1 xfailed. The false-positive risk from the plan is confirmed in the repo: scrub("Total 100 200 3000 items") now returns "Total [REDACTED] items". test_mixed_pii_and_text is still xfailed because of the street_address over-match, as planned.