# Rubric: is this reproduction package ready to post?

<!--
THIS IS THE PART YOU WRITE. The skill in SKILL.md executes whatever
checks you define here. It ships empty on purpose: the judgment is your
work.

A filled rubric must contain:

1. At least one row in the checks table. Each row needs all four
   columns:
   - Check: a short name (used in the output JSON).
   - Evidence: exactly what to look at, and where in the package. Name
     the part (the claim comment, the repro report's environment
     record, the artifacts read against the issue's description, the
     repo-facts block) or a location from your
     references/evidence-guide.md. "The report" is not a source; "the
     output excerpt read against the error the issue describes" is.
   - Pass condition: a decision rule about the OUTCOME that someone
     else could apply and get your answer. Judge the thing itself (does
     the artifact show the issue's behavior?), never the write-up's
     shape (how many steps it has, how long it is, whether it uses a
     template's headings). Structure-shaped checks are what make
     graders disagree with themselves.
   - Weight: `required` (a fail here holds the package) or `preferred`
     (never changes the verdict).

2. A verdict rule below the table: how the check grades combine into
   accept (ready) or reject (hold), including how `unclear` is
   treated. The verdict space is binary. If you write no rule for
   `unclear`, the skill treats it as fail.

Cover what actually gets bad packages posted. The lecture named the
proof families: the environment is recorded, the steps are complete
and followable, the behavior shown matches the issue (not an adjacent
one), the outcome is stated honestly (an evidenced cannot-reproduce is
a pass, a confident wrong-target is not), and the words respect the
repo's conventions. A rubric that ignores a family will fail eval
packages designed around that family.
-->

## Checks

| Check | Evidence | Pass condition | Weight |
|---|---|---|---|
| environment-disclosed | The repro report's environment record (version/commit, OS, install method) | All three are stated with enough specificity that someone else could set up the same environment | required |
| input-matches-issue | The input data/file used in the repro report, read against the input described or linked in the issue | PASS if the input is the same as the issue's, OR an explicitly-noted, justified substitute that preserves the specific triggering condition (e.g. the same kind of invalid/unrecognized element). The substitute need not be the identical file. FAIL only if the substitution silently changes what could trigger the failure, or is unexplained. | required |
| command-matches-issue | The exact command and flags run in the repro report, read against the command the issue reporter ran (or a stated equivalent) | PASS if the command and flags match the issue's, even when a substituted input path/file is used in place of the original (per input-matches-issue above). FAIL if flags differ in a way that could change behavior, or are unexplained. | required |
| steps-are-followable | The ordered sequence of setup and run steps in the repro report | Someone with the stated environment could execute the steps in order and reach the same point, with no undocumented or assumed setup | required |
| observed-behavior-matches-issue | The output/error/panic excerpt in the repro report, read against the failure the issue describes | PASS if the observed behavior is the same failure as the issue (same error type / panic signature / behavior) — OR, when the report honestly states it could not reproduce the behavior, PASS if the attempt was genuine and specific (real steps taken, real conditions tried) and the report says plainly what it observed instead. FAIL if the report claims to have reproduced the issue's failure but the behavior shown is actually different, without acknowledging the difference. | required |
| conclusion-is-honest | The stated conclusion in the repro report, read directly against the evidence shown above it | The conclusion is supported by the evidence shown, including an honest "could not reproduce" when that's what the evidence shows; fails if it claims the reported bug when the evidence actually shows a different bug or no bug at all | required |
| conventions-followed | The repo's stated contribution policy text (repo-facts block: CONTRIBUTING.md / AI_POLICY.md), quoted as it reads, read against the claim/repro comment text | PASS by default. FAIL only if the policy text contains an explicit disclosure OBLIGATION for this kind of comment (issue/claim/repro comments, not PR-only requirements) — language to the effect of "AI usage must be disclosed" or "must state the tool used" — AND the comment contains no statement disclosing that AI assistance was used. Do not fail on policies that only ask for human-written/authentic comments, understanding your own code, or avoiding low-quality AI content — those are not disclosure obligations, and are satisfied whether or not AI is mentioned. Never infer a disclosure requirement the policy text does not state. | required |

## Verdict rule

Accept (ready) only if every required check above passes. `unclear`
counts as fail for scoring purposes, except when the skill itself
marks a check `unclear` / `not yet applicable` because its evidence
doesn't exist yet (claim-only draft mode) — those are excluded from
the verdict, per SKILL.md. Any single required check that fails →
reject (hold).

<!-- State how the grades above combine into accept or reject, and how
unclear is treated. Example shape (write your own): "accept if every
required check passes; preferred checks never change the verdict;
unclear counts as fail." -->
