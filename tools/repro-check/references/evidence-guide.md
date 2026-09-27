# Evidence guide: where proof lives in a reproduction package

<!--
THIS IS THE PART YOU WRITE (new this week: Unit 1 handed you this file
finished; the scaffolding fades). The skill uses this guide as its map:
for every kind of proof a rubric check names, this file says WHERE to
find it in a package and WHAT GOOD LOOKS LIKE when you do.

Under each family heading below, write:

- Where it lives: the exact places to look. In an eval bundle (which
  section of the package: the issue context, the repo-facts block, the
  claim comment, the repro report and its parts). In live mode (where
  on GitHub or in the draft: the issue thread, the repo's docs, the
  student's draft comment).
- What good looks like: one or two sentences someone else could apply.
  Prefer observable conditions ("the versions named match what the
  issue targets, or the difference is called out") over adjectives
  ("environment is thorough").

A rubric check whose evidence this guide cannot locate is a check
nobody else can execute; the rubric swap showed you what that feels
like. Write the map you wish your grader had.
-->

## Environment

Where it lives:
- Eval bundle: the repo-facts block (target version/commit) read
  against the repro report's own "Environment" section.
- Live mode: the repro report draft's environment section, read
  against the issue thread (the version the reporter named, or the
  repo's README/install docs if the issue doesn't state one).

What good looks like: the report states version/commit, OS, and
install method, and the version named matches what the issue targets
— or the report explicitly calls out the difference and says why it
still applies.

## Steps

Where it lives:
- Eval bundle: the repo-facts block's original command/input (if
  given) or the issue context's description of how to trigger it,
  read against the repro report's input, command, and ordered steps.
- Live mode: the issue thread (the reporter's own command/input, if
  posted) and the repo's docs for sandbox setup, read against the
  student's draft repro report.

What good looks like: the input used is the same as the issue's (or
an explicitly-noted, justified variant that couldn't change the
failure mode); the command and flags match the issue's or a stated
equivalent; and the steps are ordered and complete enough that someone
starting from the stated environment, with no undocumented setup,
reaches the same trigger point.

## Behavior shown

Where it lives:
- Eval bundle: the issue context's description of the failure, read
  against the repro report's output/error/panic excerpt.
- Live mode: the issue thread's stated behavior (error text, panic,
  screenshot), read against the draft repro report's captured output.

What good looks like: the artifact shows the SAME failure as the issue
— same error type, same panic signature, or same observable behavior
— not merely "an error occurred" and not a different failure produced
by a different input or command.

## Honesty

Where it lives:
- Eval bundle: the repro report's stated conclusion line, read
  directly against the evidence excerpt sitting above it in the same
  report.
- Live mode: the draft comment's conclusion sentence, read against the
  student's own captured output from the Behavior-shown step.

What good looks like: the conclusion claims exactly what the evidence
supports — including an honest "could not reproduce" when that's what
happened — and does not claim the reported bug, a fix, or a timeline
when the evidence only shows a different bug, no bug, or an
inconclusive result.

## Comms

Where it lives:
- Eval bundle: the repo-facts block's stated contribution conventions
  (e.g. an AI-assistance disclosure requirement), read against the
  candidate claim/repro comment text.
- Live mode: the repo's CONTRIBUTING file or issue template, read
  against the student's draft comment, plus `voice-guide.md`'s own
  rules (live mode only).

What good looks like: the comment follows every convention the repo
states — most importantly, discloses AI assistance if the repo's
policy requires it — and is specific to this issue rather than
boilerplate; a claim comment promises investigation only, never a fix
or a date.