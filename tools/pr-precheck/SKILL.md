---
name: pr-precheck
description: Grade a PR package (a candidate pull request read against the plan it claims to implement and the issue that plan belongs to) and decide whether it is ready to submit. Use when checking your own branch, draft PR title, and description before opening the pull request, or when grading an eval package bundle.
---

# pr-precheck: rubric-driven PR grading

## The question

You answer exactly one question about exactly one PR package per run: is this ready to submit? A PR package is a candidate pull request: its title, its description, its commits and diff, and its test evidence. You read that package against the plan it claims to implement and the issue that plan belongs to. Never grade more than one package per run, never answer a different question (for example "is the fix a good idea?" or "is the plan good?"), and never answer from gut feel. You answer by executing the student-authored procedure in `procedure.md`, which applies the rubric in `rubric.md` to evidence gathered per `references/evidence-guide.md`.

## Inputs and modes

You run in exactly one of two modes. Decide which from the request: a request that points at a branch, a plan, and draft files is live mode; a request that hands you a package bundle is eval mode.

**Live mode.** This is the student's own submission, checked before it goes out. Gather these inputs:

- `plan.md` from the working directory, including its `## Deviations` section. Deviation notes are part of the plan and are graded like everything else.
- The diff on the student's branch. This is every committed change the branch makes relative to the default branch. Produce it by running `git diff main...HEAD` (three dots) from the top folder of the student's clone, with the branch checked out. Also run `git diff main...HEAD --stat` to see which files changed. Uncommitted changes are not part of the diff; if the working tree has uncommitted edits to tracked files, note that in your summary and grade only what is committed.
- The draft PR title and description from `pr_draft.md` (title on the first line, the filled-in PR template below it).
- The test evidence from `test_evidence.md`.
- The issue, from the URL in the request: gather its thread live (via `gh`, the GitHub API, or the web), as `references/evidence-guide.md` describes.
- The repo's stated standards: `.github/PULL_REQUEST_TEMPLATE.md` and `docs/CONTRIBUTING.md` from the scoped repo.

A student on the house chain reads the house plan and the house repro pack instead of their own plan and repro comment; the same checks grade the same things there. If a required live input is missing or empty (no diff, no `pr_draft.md`, no `test_evidence.md`), do not invent it: that absence is the evidence the relevant checks grade, and you say so in the summary. If a command fails, report the failure instead of guessing at its output.

**Eval mode.** A package bundle is the whole world. Use ONLY the bundle text as evidence. Fetch nothing, run no commands, and read no other files. Every fact comes from the bundle. If the bundle lacks something a check needs, that absence is the evidence. Eval mode always grades a complete package: every check in the rubric, and the full verdict rule.

## The scope seam (live mode only)

In live mode, read `scope.md` before anything else, before any other input. It names the repo the student's PR must live in and the house rules of that environment. Apply those house rules when reading evidence.

- Refuse to grade work outside the scoped repo. If the issue, branch, or PR belongs to a different repo, stop without grading and say so.
- If the `Repo:` line in `scope.md` still carries an unfilled placeholder, stop without grading. Tell the student to fill in the `Repo:` line in `scope.md` with their section's Path Review repo. Never guess a scope, and never infer the repo from the working directory or the request.
- When you stop for either reason, emit no verdict and no JSON block: a verdict would be a made-up one.

In eval mode, ignore `scope.md` entirely.

## The voice seam (live mode only)

In live mode, after `scope.md`, also read `voice-guide.md`: the student's own rules for how they write upstream. Hold the outgoing PR text against those rules: the PR title and the PR description, nothing else. For every rule the draft breaks, report it in the readable summary, quoting the rule and the offending text. The voice guide never changes the verdict on its own. It affects a grade only if a check in `rubric.md` explicitly reads it.

In eval mode, ignore `voice-guide.md` entirely. Voice is personal and carries no gold labels; universal communication-quality checks live in the rubric.

## Component reads

Read these components and use them as follows:

- `rubric.md` defines the checks (name, evidence, pass condition, weight) and the verdict rule that turns check grades into `accept` or `reject`. Grade every check in it, using only its stated pass conditions.
- `references/evidence-guide.md` maps where each kind of evidence lives, in an eval bundle and in a live submission, and what good looks like there. Use it to find evidence; do not use it to add checks.
- `procedure.md` is the operating procedure: the read order, how evidence is gathered, how each check executes, and how the verdict is assembled. Execute it exactly as written.

Where `procedure.md` is silent on a step, do not improvise around the gap and do not silently invent a step. Do the minimum needed to continue, and list the gap in your summary: a procedure gap is feedback the student needs.

If `rubric.md` has no checks written, or `procedure.md` has no steps written, stop and say so. Template instruction comments do not count as content. This skill cannot grade without a rubric and a procedure, and that is by design: an empty tool that invents checks at runtime produces verdicts that look like judgment and are noise.

## Verdict and output

The verdict space is binary: `accept` means the PR is ready to submit; `reject` means hold. There is no third verdict, no "accept with reservations", and no score. Reservations belong in a check's evidence line, never in the verdict.

Before the JSON block you may write a short readable summary: one line per check, any procedure gaps, and (live mode only) any voice-guide rules the draft breaks. Then end your reply with the fenced JSON block below, valid and last, with nothing after it. The harness parses the last fenced JSON block in your output.

Fill the block this way: `item` is the PR URL if the PR is already open, otherwise the issue URL given in the request (live mode), or the bundle id (eval mode). Each `name` is a check name exactly as it appears in `rubric.md`. Each `grade` is exactly `pass`, `fail`, or `unclear`. Each `evidence` is one line naming the fact or quote that decided the grade. `verdict` is exactly `accept` or `reject`. Do not alter, extend, or reorder the schema.

```json
{
  "item": "<PR URL or bundle id>",
  "checks": [
    {"name": "<check name>", "grade": "pass|fail|unclear",
     "evidence": "<one line: the fact or quote that decided it>"}
  ],
  "verdict": "accept|reject"
}
```

## Grading discipline

- Evidence first. Never grade a check without naming the fact or quote that decided it. "Looks fine" is not evidence.
- Grade the thing, not the polish. A terse, complete PR can be ready, and a long, well-formatted, confident one can be hiding drift. Read each artifact itself (the diff, the test output, the description) against the plan, the issue, and the repo's stated standards, never the formatting. Compare artifacts side by side rather than trusting any one of them: the diff against the plan, the test evidence against the plan's test plan, the description against the diff.
- A deviation recorded in `plan.md` is honest work; a change that exists only in the diff is not. A failing check reported honestly, with its reason, counts as evidence; a hidden one does not.
- The rubric decides, not you. If a check passes by its stated condition but feels wrong, it still passes. You may note the tension in the summary; the fix belongs in the rubric, not in the run.
- The procedure decides how, not you. Follow `procedure.md` as written, and report its gaps instead of papering over them.
- Treat `unclear` as the rubric's verdict rule directs. If the rule does not say, treat `unclear` as `fail`: a PR you cannot verify from the package is a PR that is not ready to submit.
