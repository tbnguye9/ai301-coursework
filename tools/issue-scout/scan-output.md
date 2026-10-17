I ran the scan and graded the top 5. 4 were accepted and 1 was rejected because someone already has a PR open for it.

Funnel: the 4 queries returned 399 unique issues. The ranking filters dropped 4: 3 for a blocking label and 1 for having 10+ comments. That left 395, ordered by your preferred labels, then fewest comments, then most recent, with at most 2 per repo. All 5 picks came from the good first issue queries (q1 or q2), had 0 comments, carried a preferred label (bug or documentation), and were updated today.

Accepted, best fit first

1. repowise #3992: an empty VITE_API_TOKEN= line is wrongly reported as a high-severity secret. (q1)
   - Fit: a small Python bug fix, opened by a project member, with the cause traced to a specific file and line. The repo has 7.8k stars and a release 2 days ago. Maintainers answered all 5 sampled outside issues within days.
   - Caveat: it's a large codebase (~3,000 files) and setup needs both uv and Node. Its sibling issue got a PR within an hour, so claim fast if you want it.
2. PortOS #11856: a failed export leaves its staging folder behind on disk. (q2)
   - Fit: a JavaScript bug fix plus one test. The owner has already written the fix and the acceptance test, and the scope is labelled small.
   - Caveat: CONTRIBUTING says to claim the issue and wait for the maintainer to assign you before starting. It also says this is a personal project, so PRs may be declined even after CI passes.
3. PortOS #11855: remove two broken symlinks in .claude/lib/. (q2)
   - Fit: a documentation fix with the steps already decided.
   - Caveat: it's very small and involves symlinks and a git submodule. Symlinks can misbehave on Windows, which is what you're on.
4. btc-toolkit #63: write a docs/cookbook.md of --json + jq recipes. (q1)
   - Fit: Python documentation work with clear "done when" criteria.
   - Caveat: it's a tiny repo (2 stars), and every recipe has to be run against the real Bitcoin network. The maintainer-response sample only shows the owner replying on their own issues.

Rejected

- repowise #3993: failed unclaimed. PR #4015 by Yi-111-a, opened today and still open, says "Fixes #3993."

Friction for your scan-notes.md (the rubric decided; these are suggested patches)

- Strategy: sorting by fewest comments and then newest fills the top 5 with issues opened a few hours ago. Those have no thread history yet, and they get claimed fast (#3993 got a PR within an hour). You could add a minimum age, such as created more than 1 day ago.
- Rubric, responds-to-issues: PortOS and btc-toolkit pass only because the owner commented on their own issues. The pass condition doesn't exclude self-replies, so it can't tell "replies to outsiders" from "talks to themselves."
- Rubric, scope: the PortOS issues come from an automated audit (labels like planner:opus-5-5, model:light). Nothing in the rubric looks at whether an issue was written by an AI audit pipeline.

scan-notes.md doesn't exist yet, so I haven't written these anywhere. I can create it with these notes.

Per your scope's rule, once you choose one, post a claim comment on the issue right away.

[
  {"item": "https://github.com/repowise-dev/repowise/issues/3992", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-17 by RaghavChamadiya (today)"},
    {"name": "responds-to-issues", "grade": "pass", "evidence": "5/5 sampled outside issues (#3955, #3614, #3962, #3469, #2535) got a member reply within 1-23 days"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "Release v0.57.0 on 2026-10-15; 345 open issues/PRs; commits today"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no cross-referenced PRs, 0 comments"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels bug + good first issue; names one bug in scanner.py:125-129 (empty public env var flagged as a secret)"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": ".github/CONTRIBUTING.md has no AI ban and tells contributors to point their coding agent at the repo"}
  ], "verdict": "accept"},
  {"item": "https://github.com/atomantic/PortOS/issues/11856", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-17 by atomantic (merged PR #11846)"},
    {"name": "responds-to-issues", "grade": "pass", "evidence": "Owner commented within 60 days on 5/5 sampled issues (#11683, #10181, #11221, #11695, #11666), all self-authored"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "Release v2.96.0 on 2026-10-15; 54 open issues/PRs; commits today"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no linked or cross-referenced PRs, 0 comments"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels bug, good first issue, effort:low; 'Fix (decided)': wrap writes + enqueueJob in try/catch with rm"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "CONTRIBUTING.md has no AI ban; repo ships AGENTS.md and CLAUDE.md"}
  ], "verdict": "accept"},
  {"item": "https://github.com/atomantic/PortOS/issues/11855", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-17 by atomantic"},
    {"name": "responds-to-issues", "grade": "pass", "evidence": "Owner commented within 60 days on 5/5 sampled issues, all self-authored"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "Release v2.96.0 on 2026-10-15; 54 open issues/PRs"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no linked or cross-referenced PRs, 0 comments"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels documentation, good first issue, effort:low; 'Fix (decided)': git rm two dangling .claude/lib symlinks"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "CONTRIBUTING.md has no AI ban; AGENTS.md present"}
  ], "verdict": "accept"},
  {"item": "https://github.com/devdavidejesus/btc-toolkit/issues/63", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-17 by devdavidejesus (merged PR #68)"},
    {"name": "responds-to-issues", "grade": "pass", "evidence": "Owner commented on #21 within 2 days (self-authored; only 2 commented issues found)"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "Release v1.8.1 on 2026-10-15; commits today"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no linked or cross-referenced PRs, 0 comments"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels documentation + good first issue; add docs/cookbook.md with 5-8 recipes, with explicit 'Done when'"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "CONTRIBUTING.md has no statement about AI"}
  ], "verdict": "accept"},
  {"item": "https://github.com/repowise-dev/repowise/issues/3993", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-17 by RaghavChamadiya"},
    {"name": "responds-to-issues", "grade": "pass", "evidence": "5/5 sampled outside issues got a member reply within 1-23 days"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "Release v0.57.0 on 2026-10-15; 345 open issues/PRs"},
    {"name": "unclaimed", "grade": "fail", "evidence": "Open PR #4015 by Yi-111-a, created 2026-10-17, body says 'Fixes #3993.'"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels bug + good first issue; names hardcoded 'Auto-proposed' wording at compose.py:220-230"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": ".github/CONTRIBUTING.md has no AI ban"}
  ], "verdict": "reject"}
]

## Scan 2 (after fixes)

I ran the scan and graded the top 5. All 5 passed the rubric, but that mostly shows the rubric is too easy on small, brand-new repos. Read the friction section before you pick one.

Funnel: each of the 4 queries returned the 100-result cap, which came to 398 unique issues. The ranking filters dropped 9: 5 had 10 or more comments and 4 had a blocking label. That left 389. I ordered them by preferred label, then fewest comments, then most recently updated, and capped each repo at 2, which left 218. All 5 picks have 0 comments and a preferred label (bug or documentation). Every pick was created on 2026-09-16 or 2026-10-09.

Accepted, best fit first

1. babelscribe #25: list babelscribe in 9 MCP and AI-tool directories. It came from q1 and is labelled documentation and good first issue.
   - Fit: Python docs work that you could finish in two weeks. It has a CONTRIBUTING.md, and the owner says "comment to claim it."
   - Caveat: most of the work is submissions to other people's directories and awesome-lists, not changes to this repo. The repo is 11 days old and has 6 stars.
2. Stellar-PurplePay #4: write a Freighter wallet troubleshooting FAQ and link it from the connect-error UI. It came from q2 and is labelled documentation and good first issue.
   - Fit: JavaScript docs work with clear acceptance criteria and a long CONTRIBUTING.md.
   - Caveat: the repo is 8 days old with 0 stars, and the issue opener labelled their own issue. Reproducing the errors needs the Freighter browser wallet on Stellar testnet. That's free, but it's crypto tooling, and the linked component is TypeScript.
3. avoid-ai-writing #322: rewrite regressions that delete source content. It came from q4 and is labelled bug and help wanted.
   - Fit: by far the healthiest repo of the five: 5k stars, a release on 10-15, a welcoming CONTRIBUTING.md and a CLAUDE.md.
   - Caveat: the work is LLM-eval regression research with cross-family gates, not a small bug fix. The owner's open draft PR #404 works on the same problem. It doesn't formally close #322, so unclaimed passed, but it overlaps.
4. StubbleAI #3: add a GET /api/health/data FastAPI endpoint with tests. It came from q1.
   - Fit: Python with clear acceptance criteria, and it includes tests.
   - Caveat: this is a new feature, not a fix. The repo has no CONTRIBUTING.md, 1 star, and a satellite and weather forecasting domain.
5. ai-issue-triage-agent #4: detect patch-apply conflicts. It came from q3.
   - Caveat: the owner calls it "a later-stage capability", so it's really a feature. The repo has no CONTRIBUTING.md, 2 stars, and no releases.

Rejected: none.

responds-to-issues is unclear for all 5. Every sampled issue in every repo was opened by its owner, so the new outsider rule had nothing to measure.

Per your scope rule, post a claim comment on the issue as soon as you choose one.

Friction for scan-notes.md (suggested patches; the rubric decided this run)

- Rubric, repo-in-use: the "commits within the last 30 days" clause lets a repo that is days old pass. Stellar-PurplePay (8 days old, 0 stars) and babelscribe (11 days old) pass with no real users. One option is to also require a repo age, such as 90 days or more, or a minimum star count.
- Rubric, scope-is-bounded: the pass condition says "however brief or large", so #322's research-sized work and #25's 9-part checklist both pass. The evidence guide says umbrella or checklist issues should fail scope, but the rubric's wording overrides it.
- Strategy: with --created "<2026-10-10" and newest-first ordering, q1 and q2 still return only one day of issues (2026-10-09), and that day is full of new repos posting good-first-issue batches. Comment-count ordering then favours issues nobody has looked at. You could vary the created window, or prefer older issues that a maintainer has touched recently.
- Strategy: q3 and q4 (help wanted + bug) surfaced owner-filed feature work. #4 is labelled bug but describes a capability that hasn't been built yet.

I haven't written these to scan-notes.md because that file is in your own voice. I can append them if you want.

[
  {"item": "https://github.com/phonology024/babelscribe/issues/25", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-10 by phonology024 (7 days ago)"},
    {"name": "responds-to-issues", "grade": "unclear", "evidence": "All 5 sampled issues (#1,#2,#3,#4,#7) opened by the owner; no outsider-opened issue to measure"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "Release v0.3.2 on 2026-10-06; commits within 30 days"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no cross-referenced PRs, 0 comments"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels documentation, good first issue, help wanted; names 9 specific directory submissions"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "CONTRIBUTING.md present with no AI-related prohibition"}
  ], "verdict": "accept"},
  {"item": "https://github.com/Stellar-PurplePay/Stellar-PurplePay/issues/4", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-10 by winningtalker-commits (7 days ago)"},
    {"name": "responds-to-issues", "grade": "unclear", "evidence": "5 sampled issues (#12,#13,#21,#22,#23) all have 0 comments; no maintainer replies to measure"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "No release, 24 open issues/PRs, but commits on 2026-10-10 (within 30 days)"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no cross-referenced PRs, 0 comments"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels documentation, good first issue; create docs/freighter-troubleshooting.md and link it from WalletConnect"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "CONTRIBUTING.md present with no AI-related prohibition"}
  ], "verdict": "accept"},
  {"item": "https://github.com/conorbronsdon/avoid-ai-writing/issues/322", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-15 by conorbronsdon (merged PR #407)"},
    {"name": "responds-to-issues", "grade": "unclear", "evidence": "All 5 sampled issues (#199,#206,#205,#351,#399) opened by the owner"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "Release v3.38.0 on 2026-10-15; 5,061 stars"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees; draft PR #404 cross-references it but closes no issues, and the body calls it 'related ... evidence', 'Keep this issue open'"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels bug, help wanted; names failures: deleted source content and omitted final artifact"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "CONTRIBUTING.md welcomes contributions with no AI ban; repo ships CLAUDE.md"}
  ], "verdict": "accept"},
  {"item": "https://github.com/Vansh-codi/StubbleAI/issues/3", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last human commit 2026-10-17 by Vansh-codi"},
    {"name": "responds-to-issues", "grade": "unclear", "evidence": "Only other issue (#2) opened by the owner, 0 comments"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "Release s1.0.0 on 2026-09-20; commits today"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no cross-referenced PRs, 0 comments"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels documentation, enhancement, good first issue; names a GET /api/health/data endpoint with acceptance criteria"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "No CONTRIBUTING.md or AI policy file found; silence passes"}
  ], "verdict": "accept"},
  {"item": "https://github.com/Ragini-Roy7/ai-issue-triage-agent/issues/4", "checks": [
    {"name": "maintainer-alive", "grade": "pass", "evidence": "Last commit 2026-10-10 by Ragini-Roy7 (7 days ago)"},
    {"name": "responds-to-issues", "grade": "unclear", "evidence": "All 5 sampled issues (#8-#12) opened by the owner, 0 comments"},
    {"name": "repo-in-use", "grade": "pass", "evidence": "No release, 15 open issues/PRs, but commits on 2026-10-10 (within 30 days)"},
    {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no cross-referenced PRs, 0 comments"},
    {"name": "scope-is-bounded", "grade": "pass", "evidence": "Labels bug, help wanted; names conflict detection/reporting when a patch cannot apply cleanly"},
    {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "No CONTRIBUTING.md or AI policy file found; silence passes"}
  ], "verdict": "accept"}
]

## Graded picks

Evidence is in for all three issues. All three pass every required check, so all three are accepted. Ranked by your fit profile:

Accepted, best fit first

1. ONSdigital/Charts#504: add white halos to the data labels on "Range arrow dot bar reference" charts. (direct)
   - Why it fits best: the repo is JavaScript (D3), which is one of your two strongest languages. It's a small display change, and the issue already includes a code snippet showing the fix. Several people are actively merging PRs (henryjameslau, SamWDataVis, nrennie, last merge 2026-10-09). Nothing needs to be installed or paid for to reproduce it.
   - Checks: maintainer-alive pass, repo-in-use pass (repo created 2023), unclaimed pass, scope pass (labelled good first issue), AI policy pass (the repo has no CONTRIBUTING.md, and no policy counts as a pass).
   - responds-to-issues: unclear. Team members do reply quickly to each other's issues (#484 got a reply the same day). But GitHub labels those replies CONTRIBUTOR, not Owner/Member/Collaborator, so the rubric's condition can't be met.
   - Caveat: there's no CONTRIBUTING.md, which falls short of the "clear contributing guidelines" in your profile.
2. harshithkantamneni/obsidian-engine#34: the setup wizard shows FAL_KEY as missing when only FAL_API_KEY is set. (direct)
   - Why it fits: it's a Python bug fix with exact line pointers and a suggested approach. It has both bug and good first issue labels, and the repo has a CONTRIBUTING.md.
   - Checks: maintainer-alive pass (last commit 2026-09-25, 22 days ago), repo-in-use pass (v0.1.0 released 2026-09-25, repo created 2026-03-27), unclaimed pass (no assignee, comments, linked PRs or cross-references), scope pass, AI policy pass (no ban, and the repo has a CLAUDE.md).
   - responds-to-issues: unclear. All 8 sampled issues were opened by the owner, and none has any replies.
   - Caveats: it's a single-maintainer repo with 2 stars. It has gone quiet since 2026-09-25, and the last 30-day commit check would fail around 2026-10-25.
3. Mattbusel/srfm-lab#7: widen CI's ruff check by fixing undefined names outside the tested core. (direct)
   - Checks: maintainer-alive pass (2026-10-09), repo-in-use pass (repo created 2026-04-03), unclaimed pass, scope pass (good first issue, specific actions), AI policy pass (CONTRIBUTING.md doesn't mention AI).
   - responds-to-issues: unclear. All sampled issues were opened by the owner, with no replies.
   - Why it ranks last: it's a quant-trading research lab, which is close to the math-heavy area your profile avoids. The task is also loosely bounded: about 150 errors, and you "pick one directory." Rubric tension, not a verdict change: a recent commit says "code and downloads moved to GitLab", and CONTRIBUTING.md links to GitLab labels. A GitHub PR may never be reviewed there. Ask on the issue where PRs should go before you claim it.

Rubric frictions to log in scan-notes.md

- responds-to-issues came out unclear on all three. Repos the curated list seeded recently have no outside-opened issues to sample. ONS's org members also show up as CONTRIBUTOR, so the badge-based condition misses a team that clearly is responsive.
- No check catches "the repo has moved its contributions off GitHub" (srfm-lab).

Remember the scope rule: once you commit to one of these, comment on the issue to claim it.

[
  {
    "item": "https://github.com/ONSdigital/Charts/issues/504",
    "checks": [
      {"name": "maintainer-alive", "grade": "pass", "evidence": "henryjameslau commit 2026-10-09 (8 days ago), merged by SamWDataVis; bot commit 2026-10-13"},
      {"name": "responds-to-issues", "grade": "unclear", "evidence": "Sampled issues opened by team members; same-day reply on #484 but repliers' association is CONTRIBUTOR, not owner/member/collaborator"},
      {"name": "repo-in-use", "grade": "pass", "evidence": "Commits within 30 days; 37 open issues+PRs; repo created 2023-04-05"},
      {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, no comments, no linked or cross-referenced PRs"},
      {"name": "scope-is-bounded", "grade": "pass", "evidence": "Specific change (white halo on .dataLabels for one chart type) with code snippet; label 'good first issue' added by maintainer"},
      {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "No CONTRIBUTING.md or AI policy file; silence passes"}
    ],
    "verdict": "accept"
  },
  {
    "item": "https://github.com/harshithkantamneni/obsidian-engine/issues/34",
    "checks": [
      {"name": "maintainer-alive", "grade": "pass", "evidence": "Last default-branch commit 2026-09-25 (22 days ago) by harshithkantamneni"},
      {"name": "responds-to-issues", "grade": "unclear", "evidence": "All 8 sampled issues opened by the owner; no outsider-opened issues to sample"},
      {"name": "repo-in-use", "grade": "pass", "evidence": "Release v0.1.0 on 2026-09-25; repo created 2026-03-27 (204 days)"},
      {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, zero comments, no linked PRs, timeline shows only labeling events"},
      {"name": "scope-is-bounded", "grade": "pass", "evidence": "Wizard only checks FAL_KEY, not FAL_API_KEY, with line pointers; labels 'bug', 'good first issue'"},
      {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "CONTRIBUTING.md has no AI prohibition; repo includes CLAUDE.md"}
    ],
    "verdict": "accept"
  },
  {
    "item": "https://github.com/Mattbusel/srfm-lab/issues/7",
    "checks": [
      {"name": "maintainer-alive", "grade": "pass", "evidence": "Last default-branch commit 2026-10-09 (8 days ago) by Mattbusel"},
      {"name": "responds-to-issues", "grade": "unclear", "evidence": "All 5 sampled issues opened by the owner on 2026-09-25; no replies"},
      {"name": "repo-in-use", "grade": "pass", "evidence": "Commits within 30 days; repo created 2026-04-03 (197 days)"},
      {"name": "unclaimed", "grade": "pass", "evidence": "No assignees, zero comments, no linked PRs, timeline shows only labeling event"},
      {"name": "scope-is-bounded", "grade": "pass", "evidence": "Fix ruff-reported undefined names in one directory and add it to CI; label 'good first issue'"},
      {"name": "contribution-policy-allows-ai", "grade": "pass", "evidence": "CONTRIBUTING.md contains no statement about AI contributions"}
    ],
    "verdict": "accept"
  }
]
