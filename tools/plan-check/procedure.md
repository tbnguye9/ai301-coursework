# Procedure: how this skill grades a plan package

These steps grade a plan; they do not make one. Follow them in order and use only the package text (or, in live mode, the locations named in references/evidence-guide.md). If a step says to note something, keep the note short and quote the exact words from the package. If a step is silent about something you need, say so in the summary instead of inventing a step.

## Read order

Read the parts in this order. The order matters: the Repro evidence is read first so the plan's cause is judged against what the repro actually showed, not against how the plan describes it.

1. Read **Repro evidence** first. Note three things: the exact input or action used, the exact observed result (what failed and how), and the expected result. Note which component, file or behavior the repro touched.
2. Read the **Issue**. Note the reported symptom and any detail that differs from the repro (a different version, input, or platform).
3. Read **Thread highlights**. Note anyone who has claimed the issue, any maintainer request or objection, and any plan or fix already posted. If it says "0 comments", note "no thread activity".
4. Read **Repo facts**. Note the contribution policy, any AI disclosure requirement, any statement about how outside changes are reviewed, and bug-report conventions.
5. Read the **Candidate plan**. Note the stated cause, the stated change, what is named as in and out of scope, the files or functions named, the test, and any risks or unknowns.
6. Read the **Candidate plan comment** last. Note what it claims, what it promises, and what it says about the thread or repo conventions.

## Evidence gathering

For each check, pull exactly this and record it before grading. Do not hunt anywhere else.

1. **diagnosis-fits-evidence**: take the plan's stated cause (the sentence after "Cause" or its equivalent in the plan) and put it beside the repro notes from Read order step 1. Record: does the cause explain the same input and the same symptom, and does anything in the repro contradict it?
2. **change-addresses-cause**: take the stated cause and the stated change. Record: does the change remove the stated cause, or only suppress, special-case or work around the symptom?
3. **scope-bounded**: take the plan's in-scope and out-of-scope statements. Record: how many separate changes are described, where each lands, what is explicitly excluded, and whether the stated change alone fixes the reported bug.
4. **stranger-can-start**: take the files, functions or locations the plan names, and its approach. Record: is there a concrete place to open and a concrete action to take, or is something left open?
5. **test-shows-fix**: take the plan's test and set it beside the repro steps. Record: does it reuse or derive from the repro steps, does it name an observable expected result after the fix, and would that result differ from what happens with the bug present?
6. **claims-match-certainty**: take every statement in the plan and comment worded as fact (reproduced, confirmed, fixes, will). Record which ones the repro notes establish and which ones go beyond them. Also record whether the plan states its unknowns as unknowns.
7. **comment-fits-thread-and-repo**: take the thread notes and the repo-facts notes and set them beside the comment. Record: does the comment duplicate or step on a claim, ignore a maintainer request, omit a required disclosure or format, or say "same as above" without its own plan? Record whether it acknowledges any relevant policy note.
8. **comment-matches-plan**: set the comment beside the plan. Record whether the cause, change and test agree, and whether the comment adds scope or promises something the plan does not contain.

## Check execution

1. Run the checks in the rubric's table order, from diagnosis-fits-evidence to comment-matches-plan. Grade each one `pass`, `fail` or `unclear`.
2. Grade each check only from the notes recorded in Evidence gathering. Do not re-read the whole package for a check; go back to the one part named for it only if a note is missing or you cannot quote it.
3. Apply the pass condition in the rubric to the notes. If the pass condition is met, grade `pass`. If the failure description in the pass condition matches the notes, grade `fail`. Grade `unclear` only when the evidence the check needs is not in the package. Do not use `unclear` because the judgment is hard: make the call.
4. A check's evidence is "missing" only when the part it names is absent or empty (for example, no Repro evidence section, or no test stated in the plan). A part that says "no comments" or "no stated AI policy" is present evidence, and the check is graded normally against it.
5. Write one line of evidence per check, quoting the words from the package that decided the grade (under 15 words per quote). For a `fail` or `unclear`, say which part of the pass condition was not met.
6. Do not let one check's grade change another's. Grade each check on its own evidence.

## Verdict assembly

1. List the grades of the required checks. Preferred checks are graded and reported but are not used for the verdict.
2. If every required check is `pass`, the verdict is `accept` (ready).
3. If any required check is `fail`, the verdict is `reject` (hold).
4. An `unclear` on a required check counts as `fail`, so the verdict is `reject` (hold).
5. In the summary, quote the words from the package that decided the grade for the deciding check. For `reject`, the deciding check is the first required check, in table order, that is not `pass`. For `accept`, quote the evidence for the diagnosis-fits-evidence check.
6. End with the fenced JSON block in the output format SKILL.md requires: one entry per check (name, grade, one-line evidence) and a verdict of `accept` or `reject` matching steps 2 to 4. The JSON block must be last.
