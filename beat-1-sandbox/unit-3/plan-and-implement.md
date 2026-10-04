# Unit 3 — Plan and Build

Path: `beat-1-sandbox/unit-3/plan-and-implement.md`

Record of your plan, the branch you built it on, and the evaluation runs that produced
`eval-run.txt`. This file is graded at the path above; a copy kept anywhere else in the
repository is not read.

Complete every labelled field below. Each is graded on its own; content placed under the wrong
label is not graded.

---

## Posted upstream

**GitHub username**

tbnguye9

**Plan comment**

https://github.com/codepath/pathreview-ai301-fa26-s3/issues/53#issuecomment-5981884936

Plan for #53, building on my repro above (https://github.com/codepath/pathreview-ai301-fa26-s3/issues/53#issuecomment-5859599202).

**Cause.** The `phone_us` pattern in `safety/pii_scrubber.py` (line 16) has two defects. Its separators only allow `-` or `.`, so a space after `)` or between digit groups cannot match, and its leading `\b` cannot sit before `(`, so the `(` is never consumed. Evidence from `main`: `scrub('Contact: (555) 123-4567')` returns the text unchanged, `scrub('Contact: (555)123-4567')` returns `'Contact: ([REDACTED]'`, and `scrub('Contact: +1 555 123 4567')` is unchanged. `detect()` uses the same `PII_PATTERNS`, so one pattern change should fix both methods.

**Change.** Replace the `phone_us` pattern with `(?<!\w)(?:\+?1[-. ]?)?\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\b`. In `tests/unit/test_pii_scrubber.py`, remove the `xfail` marker from the four tests listed in the issue (as `docs/CONTRIBUTING.md` requires for strict markers) and add one regression test for `(555)123-4567`.

**Not changing.** The `street_address` pattern, which over-matches (`...Python applications.` becomes `...[REDACTED]ications.`). That is the likely reason `test_mixed_pii_and_text` still fails even though its marker cites #53, so I am leaving that marker in place. The other patterns are untouched too.

**Correction to my repro comment.** There I said `test_mixed_pii_and_text` covers the same phone gap, because its marker cites #53. Looking closer, its phone line (`555-123-4567`) is already handled, and the test most likely fails because of the `street_address` over-match above. I have not yet run it against a fix, so I cannot rule out a second cause.

**Relation to #77.** I saw that PR #77 is open for this issue and also changes `street_address`. The regex shape is close to ones already proposed in this thread; I reached it from my own repro above. This plan keeps `street_address` out so the fix stays a single pattern change; I'm happy to follow whichever split the maintainers prefer.

**How I'll check it.** Re-run `repro.py` and the pii scrubber test file. I expect both parenthesized forms to become `[REDACTED]` with no leftover `(`, `detect()` to report the parenthesized number, and the test file to go from `20 passed, 5 xfailed` to `25 passed, 1 xfailed`.

**Open risk.** Allowing spaces as separators may also redact other space-separated groups of ten digits (for example `Total 100 200 3000 items` was redacted in a standalone copy of the regex). I will confirm this in the repo and report it in the PR.

---

## Your branch

**Branch**

fix/53-phone-parenthesized-format

**Evidence**

Before the change (on `main`, commit 2f4e82f's code, repo root, venv active):

```
$ python repro.py
scrub(): Call me at (555) 123-4567 or [REDACTED]
2026-10-04 08:15:18 [info     ] pii_detected                   count=1 types=1
detect(): [{'type': 'phone_us', 'value': '555-123-4567', 'start': 29, 'end': 41}]

$ python -m pytest tests/unit/test_pii_scrubber.py -q
..xx.......x.....x....x..                                                [100%]
20 passed, 5 xfailed in 0.09s
```

Direct `scrub()` calls before the change:

```
'Contact: (555) 123-4567' -> 'Contact: (555) 123-4567'
'Contact: (555)123-4567' -> 'Contact: ([REDACTED]'
'Contact: +1 555 123 4567' -> 'Contact: +1 555 123 4567'
'Total 100 200 3000 items' -> 'Total 100 200 3000 items'
'I worked at TechCorp for 5 years developing Python applications.' -> 'I worked at TechCorp for [REDACTED]ications.'
```

After the change (branch `fix/53-phone-parenthesized-format`, commit 3942c70):

```
$ python -m pytest tests/unit/test_pii_scrubber.py -q
.......................x..                                               [100%]
25 passed, 1 xfailed in 0.10s

$ python repro.py
scrub(): Call me at [REDACTED] or [REDACTED]
2026-10-04 09:22:57 [info     ] pii_detected                   count=2 types=1
detect(): [{'type': 'phone_us', 'value': '(555) 123-4567', 'start': 11, 'end': 25}, {'type': 'phone_us', 'value': '555-123-4567', 'start': 29, 'end': 41}]
```

Direct `scrub()` calls after the change:

```
'Contact: (555) 123-4567' -> 'Contact: [REDACTED]'
'Contact: (555)123-4567' -> 'Contact: [REDACTED]'
'Contact: +1 555 123 4567' -> 'Contact: [REDACTED]'
'Total 100 200 3000 items' -> 'Total [REDACTED] items'
'I worked at TechCorp for 5 years developing Python applications.' -> 'I worked at TechCorp for [REDACTED]ications.'
```

The remaining xfail is `test_mixed_pii_and_text`, which fails because of the `street_address` over-match
(last line above), not the phone pattern. `ruff check` and `black --check` pass on both changed files.

## Eval iterations

Answer all four sections. Quote source text directly; paraphrase does not satisfy these
fields.

**Run history**

1. Smoke run with `--limit 2` (pkg-01, pkg-02): 2/2. Not a full run and not saved.
2. Full run (20 scored packages): 18/20 (bar: 18/20: PASS). This is the run saved in `eval-run.txt`; its agreement line reads `agreement: 18/20 scored items  (bar: 18/20: PASS)`.

**Package analysis**

Package: pkg-02 (sharkdp/bat#3844, a `capacity overflow` panic at `--terminal-width 1`).

My rubric decided `reject`; the gold label is `accept`. `eval-run.txt` records it as
`pkg-02  clear-accept       accept  reject   NO     failed: claims-match-certainty`.

Why my rubric read it that way: after the full run I re-graded pkg-02 alone (`--only pkg-02`, a partial run that does not touch `eval-run.txt`) and it came back `reject` again. The grader's line for the deciding check was: "Repro shows only a slice.rs panic; sibling-advance underflow at line 795 is stated as fact, unreproduced." The Repro evidence shows only the panic ("Actual: abort with `capacity overflow`, exit 101") and two controls (width 2 exits 0; width 1 without `--highlight-line` exits 0), and those fit the underflow at line 934. The plan's Change goes further: "apply the same clamp to the sibling cursor advance at line 795 so the cursor never overshoots in the first place". Nothing in the repro or the controls reaches line 795; that claim comes from the issue author's sentence "The sibling cursor advance at line 795 is the same tiny-width/wide-char pairing". My `claims-match-certainty` check passes only if "everything stated as fact is established by the Repro evidence", so a site the repro does not reach reads as an unreproduced behavior presented as confirmed. That is a fail, and a failed required check means `reject`. The same re-grade also failed the preferred check `comment-matches-plan` (the comment promises a #3803 cross-reference and a report-back that the plan lacks); a preferred check never changes the verdict.

Why the gold label says `accept`: both controls fit the line-934 mechanism, the plan bounds itself to the abort ("Not in scope: redesigning wide-char wrapping at tiny widths"), and it states its own unknown ("other underflow-prone width arithmetic may exist outside `print_line`"). So the plan is honest about what it does not know, and my check asked for direct proof of every site the plan touches where consistent indirect evidence was enough.

**Check rationale**

The check as it reads in `tools/plan-check/rubric.md`:

| claims-match-certainty | The plan's diagnosis, risks and unknowns, and the plan comment, read against what the Repro evidence actually establishes. | Pass if everything stated as fact is established by the Repro evidence, and anything the repro did not establish is stated as unknown or as a risk. Fail if the plan or comment presents a guess, an untested assumption or an unreproduced behavior as confirmed. A plan with no risks section passes if it overclaims nothing. | required |

Why it reads that way: the lecture's failure family "the unknowns are dressed up as certainty" needed a check that looks at what the plan and the comment assert, not at how they are formatted. The pass condition therefore compares each statement worded as fact with what the Repro evidence establishes, and it fails only when a guess or an untested assumption is presented as confirmed. I added the last sentence ("A plan with no risks section passes if it overclaims nothing") because calib-01 has no risks section and is graded `ready`; without it the check would reject plans for the shape of the write-up. A check that only asked for "a risks section" would be structure-shaped, since a plan can have one and still overclaim.

**Trade-offs**

This check gives up recall on good plans. On the full run it is the reason both disagreements were wrongly held: pkg-02 (`failed: claims-match-certainty`) and pkg-14 (`failed: stranger-can-start, claims-match-certainty`), which is why clear-accept scored 5/7 while wrong-cause (4/4), scope-creep (4/4), thread-convention (2/2) and unbuildable (3/3) all matched. It will keep over-holding a plan that relies on a root cause the issue author supplied and the repro supports only through controls.

I did not loosen it. The run already met the bar (18/20 with every category matched), and I have not tested whether a looser wording would flip the wrong-cause packages (pkg-01, pkg-07, pkg-11, pkg-16), which agree today. Before loosening it I would re-run those four as canaries with `--only pkg-01,pkg-07,pkg-11,pkg-16` together with `--only pkg-02,pkg-14`. I did not do that, so I cannot say what loosening would cost.

---

Related paths: `plan.md` and `eval-run.txt` in this directory; your skill's files in
`tools/plan-check/`.
