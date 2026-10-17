# Search strategy: where your scout looks, and why

<!--
THIS IS THE PART YOU WRITE. The scout in SKILL.md executes whatever
queries and filters you define here. It ships empty on purpose: the
strategy is your judgment about where YOUR first contribution lives,
and a scan without authored queries is just someone else's defaults.

A filled strategy must contain:

1. At least one query in the Queries section. Each query is a real
   `gh search issues` invocation, and each should trace to a sentence
   of your fit profile in scope.md: if you cannot say which sentence
   produced a query, the query is probably not yours. Search breadth
   is the point at this stage: prefer generous limits and let the
   ranking filters do the narrowing.

2. At least one ranking filter in the Ranking filters section. A
   filter is a condition or an ordering over fields the search
   results already carry (last activity date, assignee presence,
   label set, comment count, repo). It must be checkable from the
   result fields alone: if deciding it would need opening the issue
   page, it belongs in your rubric, not here. Ranking is the free
   stage; keep it free. Make at least one filter an ordering, or
   state your tie-break: with drop conditions alone, the scout takes
   the top of whatever order the searches happened to return, and
   the graded candidates stop being traceable to you.

3. The top-N line, kept or deliberately changed.
-->

## Queries

<!-- Real gh search invocations, one per line, each with a comment
naming the fit-profile sentence it came from. Example SHAPE (write
your own; these values belong to nobody):

gh search issues --label "good first issue" --language python --state open --limit 100 --json title,repository,labels,assignees,commentsCount,createdAt,updatedAt,url
-->

# From: "I am most comfortable in Python and JavaScript" + "a small, well-scoped bug fix, test addition, or documentation improvement"
gh search issues --language python --label "good first issue" --state open --created "<2026-10-10" --archived=false --no-assignee --updated ">2026-08-17" --limit 100 --json title,repository,labels,assignees,commentsCount,createdAt,updatedAt,url

# From: "I am most comfortable in Python and JavaScript" + "a small, well-scoped bug fix, test addition, or documentation improvement"
gh search issues --language javascript --label "good first issue" --state open --created "<2026-10-10" --archived=false --no-assignee --updated ">2026-08-17" --limit 100 --json title,repository,labels,assignees,commentsCount,createdAt,updatedAt,url

# From: "a small, well-scoped bug fix" (Python repos that mark bugs as open to outside help)
gh search issues --language python --label "help wanted" --label bug --state open --created "<2026-10-10" --archived=false --no-assignee --updated ">2026-08-17" --limit 100 --json title,repository,labels,assignees,commentsCount,createdAt,updatedAt,url

# From: "a small, well-scoped bug fix" (JavaScript repos that mark bugs as open to outside help)
gh search issues --language javascript --label "help wanted" --label bug --state open --created "<2026-10-10" --archived=false --no-assignee --updated ">2026-08-17" --limit 100 --json title,repository,labels,assignees,commentsCount,createdAt,updatedAt,url

## Ranking filters

<!-- Conditions and orderings over the free result fields, applied in
the order written. State each so a stranger could apply it and get
your ordering. Example SHAPES (write your own):

- drop any result with an assignee
- drop any result not updated in the last 60 days
- prefer fewer comments over more
-->

Applied in this order:

1. Drop any result with an assignee.
2. Drop any result not updated in the last 60 days (before 2026-08-18), because the maintainer may be gone.
3. Drop any result carrying a label named wontfix, duplicate, invalid, question, or blocked.
4. Drop any result with 10 or more comments, because long threads are usually contested or already half-solved.
5. Drop any result created in the last 7 days (created after 2026-10-10), because brand-new issues are claimed within hours and have no thread history to judge.
6. Prefer results labelled bug, documentation, or tests over results with other labels.
7. Order the remaining results by fewest comments first (ordering). Tie-break: most recently updated first.
8. From that ordered list, keep at most 2 results per repository (the first 2 in order), so the graded candidates come from several different repositories.

## How many to grade

Grade the top **5** ranked results per scan.

<!-- Five is the default because grading is the only stage that costs
money: about $0.20 per candidate, so a scan is about $1, and you can
iterate the strategy several times for less than one full regression
run. You need one good issue, not ten. Raising this number is
allowed, but it is a decision you state here in a sentence, with the
cost you are accepting; it is not a number you bump because a scan
disappointed you once. -->


