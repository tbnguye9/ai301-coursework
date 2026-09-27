# Unit 2 — Claim and Reproduce

Path: `beat-1-sandbox/unit-2/reproduction.md`

Record of your claim and reproduction on the issue you chose in Unit 1, and of the
evaluation runs that produced `eval-run.txt`. This file is graded at the path above; a copy
kept anywhere else in the repository is not read.

Complete every labelled field below. Each is graded on its own; content placed under the wrong
label is not graded.

---

## Your identity upstream

**GitHub username**

tbnguye9

---

## Posted upstream

**Claim comment**

https://github.com/codepath/pathreview-ai301-fa26-s3/issues/53#issuecomment-5859270418

Hi! I'd like to pick this one up as my course contribution. I'm
picking up the parenthesized-phone-number case in the PII scrubber
and will report back with a reproduction (environment, the input that
triggers it, and the regex behavior I observe against the four named
failing tests) before starting on a fix.

**Reproduction comment**

https://github.com/codepath/pathreview-ai301-fa26-s3/issues/53#issuecomment-5859599202

Environment: Python 3.14.0, Windows (Git Bash/MINGW64), repo cloned at
commit 2f4e82f52efbcfcc57d65b3fa5348672163ca088 (2026-09-16). Only
dependencies needed for this repro are `structlog` and `pytest`, run
in a fresh venv (`python -m venv .venv`).

Steps (from the repo root, venv activated):

```
$ pip install structlog pytest
$ python -m pytest tests/unit/test_pii_scrubber.py -v
```

Output (summary):

```
20 passed, 5 xfailed
```

The 5 xfailed tests are `test_us_phone_number_redaction`,
`test_us_phone_formats`, `test_detect_phone_pii`,
`test_phone_at_start_of_text`, and `test_mixed_pii_and_text` — all
citing issue #53.

Note: the issue names four failing tests; running the suite surfaced
a fifth, `test_mixed_pii_and_text`, also marked xfail citing #53. It
covers the same underlying gap (a phone number embedded in mixed
text), so it's included here for completeness.

To see the actual behavior directly, ran:

```python
from safety.pii_scrubber import PIIScrubber

s = PIIScrubber()
text = "Call me at (555) 123-4567 or 555-123-4567"
print("scrub():", s.scrub(text))
print("detect():", s.detect(text))
```

Output:

```
scrub(): Call me at (555) 123-4567 or [REDACTED]
detect(): [{'type': 'phone_us', 'value': '555-123-4567', 'start': 29, 'end': 41}]
```

Expected: both phone numbers redacted; `detect()` returns a phone
detection for the parenthesized number too.

Actual: the parenthesized `(555) 123-4567` is left unredacted and
`detect()` reports no PII for it, while the dashed `555-123-4567` in
the same string is redacted and detected. Matches the behavior the
issue describes exactly.

Root cause, confirmed directly: the `phone_us` pattern in
`safety/pii_scrubber.py` is
`\b(?:\+?1[-.]?)?\(?([0-9]{3})\)?[-.]?([0-9]{3})[-.]?([0-9]{4})\b`.
The separator right after the closing `)` is `[-.]?`, which allows a
dash or a period but not a space. Verified in a Python REPL:
`re.search(pattern, "(555) 123-4567")` returns `None`, while
`re.search(pattern, "(555)123-4567")` (no space) matches. The space
after `)` is what breaks the match.

## Eval iterations

Answer all four sections. Quote source text directly; paraphrase does not satisfy these
fields.

**Run history**

1. First full run: 16/20 (below the 18/20 bar). Categories:
   clear-accept 4/8, disclosure 1/1, no-evidence 4/4,
   unfollowable-comms 3/3, wrong-target 4/4. Four packages
   (pkg-05, pkg-09, pkg-10, pkg-11) failed on overly strict pass
   conditions for `input-matches-issue`, `command-matches-issue`, and
   `observed-behavior-matches-issue`.
2. Revised those three checks to allow a justified, non-identical
   input/command and an honest cannot-reproduce as PASS. Re-ran
   `--only pkg-05,pkg-09,pkg-10,pkg-11`: 4/4 agree. Ran the
   `disclosure` canary (`pkg-20`) to check for a flip: it flipped from
   reject to accept (0/1) — the check that used to catch it
   (`conventions-followed`) had never actually been exercised
   correctly.
3. Rewrote `conventions-followed` to fail only on an explicit
   disclosure obligation the comment doesn't meet, instead of
   inferring one from any AI-related policy language. Re-ran
   `--only pkg-20`: agrees (1/1). Re-ran the original four together
   with the canary (`--only pkg-05,pkg-09,pkg-10,pkg-11,pkg-20`): 5/5
   agree.
4. Second full run (confirming): 17/20. The `conventions-followed`
   rewrite over-triggered on three packages whose policies only asked
   for authentic/human-written comments or code understanding, not
   disclosure (pkg-03, pkg-07, pkg-12).
5. Narrowed `conventions-followed`'s pass condition to require an
   explicit disclosure *obligation* in the policy text, not just any
   mention of AI. Re-ran `--only pkg-03,pkg-07,pkg-12,pkg-20`: 4/4
   agree, canary still holds.
6. Third full run (confirming, saved with `--save-run eval-run.txt`):
   **19/20 — PASS (bar: 18/20)**. Categories: clear-accept 8/8,
   disclosure 1/1, no-evidence 4/4, unfollowable-comms 2/3,
   wrong-target 4/4. This is the run recorded in the committed
   `eval-run.txt`.

**Package analysis**

Package: pkg-19 (vuejs/core#15205)

Gold verdict: reject
My rubric's verdict: accept (disagreement)

My rubric passed every technical check on this package: the repro
report's environment, steps, and observed behavior all genuinely
match the issue (the candidate even re-created the reproduction from
scratch in a fresh playground to rule out a stale link, and the
CSS output shown matches exactly what the issue and the maintainer's
follow-up comment describe as broken). Where it went wrong is the
claim comment: "Kindly assign it to me, I will fix it within 2 days
guaranteed... please... keep this issue reserved for me." This
promises a fix and a deadline, which is exactly the "promise, don't
assert" rule this unit's own claim-comment guidance warns against —
a claim should promise investigation, never a fix or a date.

My rubric's `conventions-followed` check only looks for an AI-use
disclosure statement, and this repo states no AI policy, so that
check passed by default. It has no check that reads the claim
comment's tone or promises against house etiquette, so nothing in my
rubric could catch this. This is exactly the gap the eval set's
`unfollowable-comms` category is built to expose, and it's the reason
my run landed at 2/3 in that category instead of 3/3.

**Check rationale**

Quoted exactly as it now reads in `rubric.md`:

"conventions-followed | The repo's stated contribution policy text
(repo-facts block: CONTRIBUTING.md / AI_POLICY.md), quoted as it
reads, read against the claim/repro comment text | PASS by default.
FAIL only if the policy text contains an explicit disclosure
OBLIGATION for this kind of comment (issue/claim/repro comments, not
PR-only requirements) — language to the effect of "AI usage must be
disclosed" or "must state the tool used" — AND the comment contains
no statement disclosing that AI assistance was used. Do not fail on
policies that only ask for human-written/authentic comments,
understanding your own code, or avoiding low-quality AI content —
those are not disclosure obligations, and are satisfied whether or
not AI is mentioned. Never infer a disclosure requirement the policy
text does not state. | required"

This check went through two revisions before reaching this wording.
My first version failed a package (pkg-20, the repo's `AI_POLICY.md`
explicitly requires stating "the tool used and the extent of the
assistance") whose comment said nothing about AI — that version
simply checked for a disclosure statement whenever the repo mentioned
AI at all, and it correctly caught pkg-20. But that same broad
wording then over-triggered on three other packages (pkg-03, pkg-07,
pkg-12) whose repos only ask for human-written comments or a human
who understands the code, not disclosure — those are quality/
authenticity requirements, not disclosure obligations, and my rubric
was reading them as if they were the same thing. I rejected the
"any AI-related policy language triggers a check" version in favor of
the current wording, which fails only when the policy text states an
actual disclosure obligation, and treats silence as compliant
otherwise. This is the version that passed both the original miss
(pkg-20) and the three false positives it had caused.

**Trade-offs**

Loosening `input-matches-issue` and `command-matches-issue` to accept
a justified, non-identical input/command (rather than requiring an
exact match) is a deliberate trade-off: it trusts the report's own
justification for why a substitute preserves the triggering
condition, rather than independently re-deriving that equivalence
from first principles. I accept that this could, in principle, let a
package through where the substitution actually does change the
failure mode but the candidate's justification sounds plausible
without being correct. I checked this by re-running canaries after
the change (`pkg-20` at each subsequent revision) to confirm the
loosening didn't also let a disclosure-violating or conventions-
violating package back in — it didn't, and the category floor held at
1/1 for `disclosure` on the final run. I did not find, in the 20-item
scored set, a case where this trade-off actually let a wrong package
through; `unfollowable-comms` dropped to 2/3 for a different reason
(a claim-comment-tone gap named in the Package analysis section
above), not because of this loosened pair of checks.

---

Related paths: `eval-run.txt` in this directory; your skill's files in
`tools/repro-check/`.
