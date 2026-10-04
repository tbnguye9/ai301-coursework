# Evidence guide: where evidence lives in a plan package

In an eval package (for example `calib-01.md`), the parts appear as these headings: `## Repo facts`, `## Issue`, `## Thread highlights`, `## Repro evidence`, `## Candidate plan` (with the labelled lines Cause, Change, Test, and any risks), and `## Candidate plan comment`. In live mode, the same parts are the repo's CONTRIBUTING and issue template, the issue body, the issue thread, the author's posted repro comment, and the drafts `plan.md` and `comment.md`.

## Diagnosis and grounding

**Where it lives.** The stated cause is in the Candidate plan, on the line starting `Cause:` (live: the diagnosis section of `plan.md`). The behavior that cause must explain is in the Repro evidence section: the numbered steps, the "Actual" line, and any command output or panic text it quotes (live: the author's posted repro comment). The Issue section gives the reported symptom for comparison.

**What good looks like.** The stated cause would produce exactly the input and symptom the Repro evidence shows, and it cites or is consistent with something the repro observed (an output, a step that failed, a value). It is a bad sign when the cause names a different component than the one the repro touched, explains a different input than the one that failed, or is a generic phrase ("a logic error in the handler") that fits any bug. A cause is also weak when the repro contradicts it, for instance a repro showing the failure on input A while the cause only explains input B.

## Scope

**Where it lives.** In the Candidate plan, on the lines starting `Change:` with its `In:` and `Out:` statements (live: the scope section of `plan.md`). The files, functions or areas named there show how far the change reaches.

**What good looks like.** One bounded change that alone fixes the reported bug, a named location, and an explicit statement of what will not be touched. Next to a drive-by rewrite: bounded is "add one case to the post-push refresh in one function"; a drive-by is "clean up the controller", "also refactor X", or a list of unrelated edits. A scope that names no limits, or whose size cannot be judged, is not bounded.

## Executability

**Where it lives.** In the Candidate plan, the `Change:` line (files, functions) and any approach or order-of-work text (live: the files-to-touch and approach sections of `plan.md`).

**What good looks like.** A contributor who never saw the repro could open the named file or function and make the stated change. It names a concrete location and a concrete action. It is not executable when the location or action is left open ("update the logic as needed", "fix it somewhere in the handler") or when the plan depends on a decision the author has not made.

## Test plan

**Where it lives.** In the Candidate plan, on the line starting `Test:` (live: the test plan section of `plan.md`). Read it against the numbered steps in the Repro evidence, since the test should reuse or derive from those steps.

**What good looks like.** It re-runs the repro steps, or a check built from them, and states the observable result that must appear after the fix (for example "at step 3 the color must flip without leaving the view"). The result would differ before and after the fix. A manual re-run of the repro is enough; automation is not required. A vague test is "verify it works", "run the test suite", or a check that would also pass with the bug still present.

## Honesty

**Where it lives.** In the Candidate plan, any risks or unknowns text, and in the claims worded as fact in both the plan and the plan comment ("reproduced", "confirmed", "fixes", "will"). Compare them with what the Repro evidence actually establishes. In live mode, also the `## Deviations` heading at the end of `plan.md`, where an honest mid-build change is recorded.

**What good looks like.** Everything stated as fact is established by the Repro evidence, and anything the repro did not establish appears as a risk or unknown. A plan with no risks section is still honest if it overclaims nothing. False confidence looks like "this will fix it" or "root cause confirmed" when the repro only showed the symptom, or a guess about code the author has not read stated as certain.

## Comms

**Where it lives.** In the Candidate plan comment, read against the Thread highlights section (who has claimed the issue, maintainer requests, existing plans) and against the Repo facts block (contribution policy, AI disclosure requirement, review expectations, bug-report conventions). In live mode: the posted comment text, the live issue thread, and the repo's CONTRIBUTING and templates.

**What good looks like.** The comment is thread-aware: it gives its own plan, does not step on someone else's claim, honors a maintainer request, includes any disclosure the policy requires, and acknowledges a relevant policy note (for example a statement that outside PRs are reviewed only selectively). Boilerplate looks like "same approach as above", a comment that could be pasted onto any issue, or one that ignores a stated requirement. The comment's cause, change and test should also agree with the plan, and it should promise nothing the plan does not contain.
