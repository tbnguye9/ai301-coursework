# Rubric: is this a good first issue?

<!--
THIS IS THE PART YOU WRITE. The skill in SKILL.md executes whatever checks
you define here. It ships empty on purpose: the judgment is your work.

A filled rubric must contain:

1. At least one row in the checks table. Each row needs all four columns:
   - Check: a short name (used in the output JSON).
   - Evidence: exactly what to look at, and where. Name the source
     (repo-facts block, issue body, comment thread, or the locations in
     references/evidence-guide.md). "The repo" is not a source; "the last
     5 default-branch commit dates" is.
   - Pass condition: a condition someone else could apply and get your
     answer. Prefer thresholds with numbers ("a maintainer commented
     within 30 days") over adjectives ("maintainer is responsive").
   - Weight: `required` (a fail here rejects the issue) or `preferred`
     (never changes the verdict; a nice-to-have that helps rank the
     issues you accept).

2. A verdict rule below the table: how the check grades combine into
   accept or reject, including how `unclear` is treated. The verdict
   space is binary. If you write no rule for `unclear`, the skill treats
   it as fail.

Cover what actually kills first contributions. The lecture named four
families: the maintainer is alive, the repo is in use, the scope fits a
newcomer, and nobody else is already on it. A rubric that ignores a family
will fail eval issues designed around that family.
-->

## Checks

| Check | Evidence | Pass condition | Weight |
|---|---|---|---|
| maintainer-alive | Last 5 default-branch commit dates (repo-facts block) | At least 1 commit within the last 30 days | required |
| responds-to-issues | Maintainer first-response sample: days-to-first-owner/member/collaborator-comment across the 5 sampled issues (repo-facts block) | At least 1 of the 5 sampled issues shows a maintainer/collaborator reply within 60 days | preferred |
| repo-in-use | Latest release date, open issues+PRs count, and last 5 default-branch commit dates (repo-facts block) | A release shipped within the last 12 months, OR the repo has 50+ open issues/PRs, OR there have been commits within the last 30 days (covers actively maintained projects that don't do formal releases) | required |
| unclaimed | Assignees field and linked PRs for this issue (repo-facts block), plus the comment thread scanned for claim signals (phrases like "I'll take this", "/assign", "opened PR #", "working on this") | No assignee; no linked PR that is currently open; and no claim signal in the comment thread that is recent or unresolved — a claim that is old (no activity for 90+ days), superseded by a stale-bot comment, or attached to a since-closed PR does not count as a current claim | required |
| scope-is-bounded | The issue body, title, and labels | The issue names a specific behavior to fix or feature to add, however brief or large the described work is, AND the issue has at least one triage label (e.g. bug, enhancement, good first issue, type::*) showing a maintainer has reviewed and accepted it into scope. An issue with no labels at all — especially one opened by an automated/bot account rather than a maintainer or community member — has not been vetted as approved scope, even if its description looks detailed | required |
| contribution-policy-allows-ai | The CONTRIBUTING.md contribution policy statement (repo-facts block) | The policy does not explicitly prohibit AI-generated or AI-assisted contributions. No statement at all, or a statement that welcomes/allows AI assistance with reviewer responsibility, both pass. Fails only when the policy explicitly states AI-generated content is not accepted | required |

## Verdict rule

Accept only if every required check grades `pass`. A check graded `unclear` 
on any required check counts as a `fail` for verdict purposes. Preferred 
checks never change the verdict — they only rank the accepted issues by fit. 
`responds-to-issues` is preferred: a slow or sparse maintainer-response 
sample should lower an issue's rank, not disqualify it outright, since even 
healthy repos often show gaps in a 5-issue sample. The remaining five checks 
are required because each is disqualifying on its own (a dead maintainer, a 
repo nobody uses, an already- and still-claimed issue, an issue with no 
maintainer-vetted scope, or a repo whose policy forbids AI-assisted 
contributions all make an issue unsuitable for a first contribution done 
with AI tooling).

<!-- State how the grades above combine into accept or reject, and how
unclear is treated. Example shape (write your own): "accept if every
required check passes; preferred checks never change the verdict, they
rank accepted issues; unclear counts as fail." -->
