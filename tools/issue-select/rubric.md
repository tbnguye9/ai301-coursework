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
| responds-to-issues | Maintainer first-response sample: days-to-first-owner/member/collaborator-comment across the 5 sampled issues (repo-facts block) | At least 3 of the 5 sampled issues show a maintainer/collaborator reply within 30 days | required |
| repo-in-use | Latest release date and open issues+PRs count (repo-facts block) | A release shipped within the last 12 months, OR the repo has 50+ open issues/PRs (signals active usage even without frequent releases) | required |
| unclaimed | Assignees field and linked PRs for this issue (repo-facts block), plus the comment thread scanned for informal claim signals (phrases like "I'll take this", "/assign", "opened PR #", "working on this") | No assignee, no linked open PR, and no claim signal found in the comment thread | required |
| scope-is-bounded | The issue body and title | The issue describes a concrete, testable change with clear expected behavior — not just a request, discussion, or open-ended idea with no spec | required |

## Verdict rule

Accept only if every required check passes. A `?` (unclear) on any required 
check counts as a fail. Preferred checks never change the verdict — they only 
rank the accepted issues by fit. This rubric currently has no preferred checks; 
all five checks are required because each one, when it fails, is disqualifying 
on its own (a dead maintainer, an unresponsive repo, a repo nobody actually 
uses, an already-claimed issue, or an unbounded scope all make an issue 
unsuitable for a first contribution).

<!-- State how the grades above combine into accept or reject, and how
unclear is treated. Example shape (write your own): "accept if every
required check passes; preferred checks never change the verdict, they
rank accepted issues; unclear counts as fail." -->