# Contribution: Make more descriptive error messages for Transport Errors

Path: `beat-2-contribution/contribution-story.md`

This file is Assignment 5, and it is graded at the path above; a copy kept anywhere else in
the repository is not read. **Keep every section header below under its exact name** — the
format criteria grade exactly that. Your course repo link is the whole submission: no tool
files and no evidence uploads are part of Assignment 5.

**Contribution Number:** [1]
**Student:** Thuan Nguyen
**GitHub Username:** tbnguye9
**Issue:** https://github.com/opensearch-project/opensearch-benchmark/issues/348
**Pull Request:** not opened yet

One repository, built across units 5 to 8, telling the whole story of your real
contribution. Fill it as you work, not at the end — the sections below ask for evidence that
is far easier to write down as it happens than to reconstruct in the last weekend.

Contribution Number stays `[1]` unless you make more than one contribution this term; it
just numbers them.

---

## Toolkit

Every story section below, from Why I Chose This Issue through Pull
Request, ends with a Toolkit block: which tool did that phase's work
and how you used it, what it produced, what difficulties or
shortcomings it presented, and what you changed or would change
because of them. Together the blocks are the thread the rubric's
Toolkit points read, and they are the raw material for your unit-9
portfolio, so keep them current as you work rather than
reconstructing them later.

A Toolkit block looks like this (copy it into each story section and
fill it there):

```text
**Toolkit**

- Tool: [which tool did this phase's work, and how you used it]
- What it produced: [described in a sentence or a short excerpt]
- Difficulties: [what fought you or fell short, or "none met"]
- What changed: [the patch, revision, or workaround, what you would
  update, or "nothing"]
```

This section also keeps one short dated entry per week of tool work,
starting below: what you built or changed that week, what broke, and
what you changed because of it. The blocks tell the story where it
happened; these entries are the toolkit's own timeline.

All four entries are graded. Keep every heading below, and fill each
one in the week it belongs to.

**Unit 5: issue-scout with my own queries, a stricter rubric, and a pre-grading filter script**

I wrote four gh search issues queries and eight ranking rules from my fit profile. My first scan was dominated by issues opened the same day (one drew a competing pull request within an hour), and responds-to-issues passed repositories only because the owner answered their own issues, so I added a creation-date window to the queries and made that check require an issue opened by someone else. The second scan then accepted several repositories only days old because repo-in-use passed on any recent commit, so I added a 90-day minimum repository age and confirmed it by grading one young and one old repository (the young one was rejected and the old one still passed). Because assignees=0 also hid claims on four candidates I checked by hand, I wrote a small script that drops issues with an open pull request before I pay to grade.

**Unit 6: a voice guard on every post I send, and a repo-memory file for opensearch-benchmark**

I added four upstream rules (two for claims, one each for questions and pings) to my voice guide, installed the guard as a Claude Code hook, and confirmed it with a wiring test that was blocked as expected; my claim on #348 then posted through it with a `pass` line in the guard log. The guard's script would not have worked on Windows as shipped (it called `claude` instead of `claude.cmd`, read files without UTF-8, and the hook command used `python3`), so I patched my copy and checked each patch with grep before relying on it. I also skipped copying the wild scope files at first, so repro-check refused to grade #348 until I replaced its `scope.md`, which cost me one wasted run. For the memory file I replaced the scoped orientation agent run with a few greps (where the message is built, the test that asserts it, the other TransportError catch sites), kept `CLAUDE.local.md` out of my PR with `.git/info/exclude` (a clean `git status` confirms it), and corrected its build section after trying it: the package refuses native Windows Python 3.14 and `make develop` needs pyenv, so the file now records the WSL venv commands that worked (`tests/metrics_test.py`: 67 passed).

**Unit 7: [one line on the tool work]**

[2-4 sentences: the ship-gate and your gate manifest. What it produced
on your real branch, what fought you, what changed because of it.]

**Unit 8: [one line on the tool work]**

[2-4 sentences: the PR-monitor and your playbook. What it read, what it
drafted, what you did with the draft.]

---

## Why I Chose This Issue

I searched with four `gh search issues` queries and eight ranking rules built from my fit profile: Python, JavaScript, Java, React and C/C++ experience, a wish to get better at the GitHub contribution workflow, and a preference to avoid math-heavy work. My scout accepted several candidates (obsidian-engine #34, ONSdigital/Charts #504, srfm-lab #7), but when I went to claim them, the course's Issue Selection site did not list the first two, and a recent srfm-lab commit says its code moved to GitLab. So I searched the site's issue titles by hand and found opensearch-benchmark #348, "Make more descriptive error messages for Transport Errors." Before claiming it, I read the code: the bare "A transport error occurred while running the operation" message the issue complains about is still produced in `osbenchmark/metrics.py`, and `tests/metrics_test.py` still asserts it, so the issue had not gone stale. I claimed it on the site and graded it with my scout.

The scout accepted it both before and after this week's scope patch, with all five required checks passing. After the patch it also gave a difficulty note of moderate: the issue does not say where in the code the transport errors surface, and it dates from 2023, so I have to check that the error path still looks the way the issue describes. The preferred check `responds-to-issues` failed on the second grading even though it passed on the first, because the 5-issue sample was different: now only #1112 was opened by an outsider and it has no maintainer reply. The issue fits me because it is one small, self-contained Python change with a `good first issue` label, in a repository with a recent commit (2026-10-14) and a recent release (1.20.0), and with no math in it. I hope to learn how to trace a message through an unfamiliar codebase, follow a repository's own rules (DCO sign-off and the developer guide), and work with maintainers who reply slowly.

My scout did its main job on #348 but fell short in three ways. It cannot tell whether a maintainer has ever looked at an issue: #348 is three years old with zero comments, and no check sees that. Its `responds-to-issues` check is unreliable on small samples: it came back `unclear` for all three of my earlier picks and then flipped from pass to fail on #348. And it searches all of GitHub while the course site lists only part of it, so two of the issues it accepted could not be claimed at all. I worked around the third problem with a helper script and a manual title search, and I did not change the rubric for the first two. A possible new preferred check would be "a maintainer has commented on the issue in the last 12 months," which I have not tried.

My claim comment: https://github.com/opensearch-project/opensearch-benchmark/issues/348#issuecomment-6390746479

**Toolkit**

- Tool: issue-scout (my own search queries and my rubric, as patched this week), plus a helper script (`~/find-candidates.sh`) that I ran before paying to grade. I graded #348 twice: once before claiming it and once after the Unit 6 scope patch.
- What it produced: accept both times with all five required checks passing. The second grading added the difficulty note (moderate) and graded the preferred check `responds-to-issues` as fail.
- Difficulties: no check for a maintainer who has never commented on an issue; `responds-to-issues` gives weak or flipping answers on small samples; the scout's search covers more than the course site lists.
- What changed: on 2026-10-24 I replaced my `scope-is-bounded` check with the course's `scope-feasible` row and added the difficulty-note section. My old check passed anything that named a behavior "however brief or large" (it let a 9-part checklist through) but also demanded a triage label; the new check rejects umbrella issues and no longer asks for a label. The verdict on #348 did not change. I wrote this in `scan-notes.md` with the date.
---

## Understanding the Issue

**Problem Description**

[In your own words, what is broken or missing?]

**Expected Behavior**

[What should happen?]

**Current Behavior**

[What actually happens?]

**Affected Components**

[Which parts of the codebase are involved?]

**Toolkit**

- Tool:
- What it produced:
- Difficulties:
- What changed:

---

## Reproduction Process

**Environment Setup**

- OS: Windows with Ubuntu 22.04.4 LTS under WSL2 (all commands below ran in Ubuntu).
- Python 3.10.12 in a venv (`python3 -m venv ~/osb-venv`).
- opensearch-benchmark 2.4.0 installed in editable mode from commit `493ef45` of `opensearch-project/opensearch-benchmark` (main), opensearch-py 2.8.0, pytest 9.1.1.
- Challenges: native Windows Python 3.14.0 is refused (`pip install -e .` fails with "requires a different Python: 3.14.0 not in '<3.14,>=3.10'"), and `make develop` needs `pyenv`, which I do not have. I used WSL with a plain venv and `pip install -e . pytest` instead. Ubuntu also needed `sudo apt-get install python3.10-venv` first. As a check, `python -m pytest tests/metrics_test.py -q` gives 67 passed.

**Steps to Reproduce**

This reproduces the code path of #348 without a live cluster. I did not have a cluster with 3 awareness attributes, so the HTTP 400 from #330 is injected by raising the same exception class with the same text.

1. Clone the repo, check out the commit above, and create the venv as described in Environment Setup. Install with `pip install -e . pytest`.
2. Save the script below as `repro_348.py` outside the clone.
3. From the root of the clone, run `python /path/to/repro_348.py`.
4. Read the printed message.

```python
import os
import sys

sys.path.insert(0, os.getcwd())

import opensearchpy
from osbenchmark import exceptions, metrics
from tests.metrics_test import OsClientTests

RequestError = opensearchpy.exceptions.RequestError
print("RequestError is a TransportError subclass:",
      issubclass(RequestError, opensearchpy.TransportError))

CAUSE = ("index_template [benchmark-metrics] invalid, cause [Validation Failed: 1: "
         "expected total copies needs to be a multiple of total awareness attributes [3];]")


def put_template(*args, **kwargs):
    raise RequestError(400, "invalid_index_template_exception",
                       {"error": {"type": "invalid_index_template_exception", "reason": CAUSE},
                        "status": 400})


client = metrics.OsClient(OsClientTests.ClientMock([{"host": "127.0.0.1", "port": "9243"}]))
try:
    client.guarded(put_template)
except exceptions.BenchmarkError as e:
    msg = e.args[0]
    print("Raised:", type(e).__name__)
    print("Message:", msg)
    print("Message mentions status 400:", "400" in msg)
    print("Message mentions invalid_index_template_exception:", "invalid_index_template_exception" in msg)
    print("Message mentions awareness attributes:", "awareness" in msg)
    print("Original error kept only as __context__:", repr(e.__context__)[:150])
```

Why this is the right path: `put_template` in `osbenchmark/metrics.py` (lines 77-78) calls `self.guarded(...)`, and `guarded` catches `opensearchpy.TransportError` (line 158). A 400 is not in its retry list (502, 503, 504, 429), so it reaches the final `else` branch that builds the message.

Observed result (output of the script, on the commit above):

```text
RequestError is a TransportError subclass: True
Raised: BenchmarkError
Message: A transport error occurred while running the operation [put_template] against your OpenSearch metrics store on host [127.0.0.1] at port [9243].
Message mentions status 400: False
Message mentions invalid_index_template_exception: False
Message mentions awareness attributes: False
Original error kept only as __context__: RequestError(400, 'invalid_index_template_exception', {'error': {'type': 'invalid_index_template_exception', 'reason': 'index_template [benchmark-metr
```

**Reproduction Evidence**

- **Commit showing reproduction:** none (the script lives outside my fork; the output above is the evidence)
- **Screenshots/logs:** the script output above. Because no logging is configured in the script, the same message and a traceback ending in `RequestError(400, 'invalid_index_template_exception')` were also printed to stderr (from `self.logger.exception(msg)`).
- **My findings:** for an HTTP 400 `invalid_index_template_exception` (the error reported in #330), the `BenchmarkError` that OSB raises says only that a transport error occurred during `put_template`, with host and port. It has no status code, error type, or reason, so it gives the user no hint to check cluster settings such as the replica or awareness configuration; the cause survives only as the exception's `__context__`. That matches what #348 asks to improve. What I have not shown: a real cluster with 3 awareness attributes, what the user sees on the command line in a real run (I do not know where OSB's logging sends the traceback), and whether other places that catch `TransportError` (`client.py`, `worker_coordinator/runner.py`, `worker_coordinator/worker_coordinator.py`) behave the same. The issue also describes a stack trace, while today the user-visible text is this generic message; the traceback is in the log. The direction I am considering, not yet decided, is to put the status code, error type and reason from the exception into the BenchmarkError message, in the style of the branches above it that already tell the user what to check.

**Toolkit**

- Tool: repro-check (my unit-2 rubric and voice guide, with the wild `scope.md` from this week), run on my claim draft first and then on the claim draft and this repro report together.
- What it produced: the first run refused to grade because `scope.md` was still the sandbox one; after I replaced it, the claim alone was accepted, and the claim plus the report was accepted with all seven checks passing. It also pointed out that my claim promised a proposed change while the report had none yet.
- Difficulties: the refused first run cost me a run. It also suggested dropping the "Commit showing reproduction: none" line, which makes sense for a post on the issue, but this report goes only into my story, where the template asks for that line.
- What changed: I replaced `scope.md` with the wild one and added to my findings the direction I am considering for the fix. My rubric did not change.

---

## Solution Approach

**Analysis**

[Your analysis of the root cause: what is causing the issue, traced
to the files and functions involved.]

**Proposed Solution**

[High-level description of your fix approach, and what you are
deliberately NOT changing.]

**Implementation Plan**

1. [Modify file X to do Y]
2. [Add or change Z]
3. [Update tests]

[Record deviations here as they happen: what changed mid-build and
why. A recorded deviation is honest work; silent drift is not.]

**Toolkit**

- Tool:
- What it produced:
- Difficulties:
- What changed:

---

## Testing Strategy

[What observable checks prove the fix: your reproduction steps re-run
against the built change (before and after), and the repo's own test
suite or checks with the outcome shown. "Tests pass" with nothing
observable named is not a strategy.]

**Toolkit**

- Tool:
- What it produced:
- Difficulties:
- What changed:

---

## Implementation Notes

[A running log, added to as you work. Date each entry. What you
built, decisions you made when you made them, wrong turns included.]

**[Date]**

[Entry]

**[Date]**

[Entry]

**Toolkit**

- Tool:
- What it produced:
- Difficulties:
- What changed:

---

## Pull Request

**PR Link:** [GitHub PR URL when opened]

**PR Description:** [what the PR says; much of the content above
adapts into it]

**Maintainer Feedback:**

- [Date]: [feedback received, or "none yet"; silence is a normal
  state and costs you nothing]
- [Date]: [how you addressed it]

**Status:** [Awaiting review / Iterating / Merged / Closed. The
status is a fact you record, never a grade: the PR is graded as
opened.]

**Toolkit**

- Tool:
- What it produced:
- Difficulties:
- What changed:

---

## Learnings and Reflections

**Technical Skills Gained**

[What you learned technically, named concretely.]

**Challenges Overcome**

[What was hard and how you solved it; point at the real events, the
Toolkit blocks above are full of them.]

**What I'd Do Differently Next Time**

[Reflection on your process.]

---

## Resources Used

[What actually helped, not a reading list. List things this story
already shows you using: the doc you followed to set the environment
up, the thread that explained the bug, the person who answered you.
One real entry beats ten plausible ones.]

- [Link to documentation that helped]
- [Discussion, issue, or post that helped]
