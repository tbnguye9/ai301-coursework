# Unit 4 — Test and Submit

Path: `beat-1-sandbox/unit-4/pull-request.md`

Record of the pull request you opened against the Path Review repo, and of the evaluation
runs that produced `eval-run.txt`. This file is graded at the path above; a copy kept
anywhere else in the repository is not read.

Complete every labelled field below. Each is graded on its own; content placed under the wrong
label is not graded.

---

## Your pull request

**Pull request**

https://github.com/codepath/pathreview-ai301-fa26-s3/pull/123

**Branch**

fix/53-phone-parenthesized-format

## Eval iterations

Answer all four sections. Quote source text directly; paraphrase does not satisfy these
fields.

**Run history**

Seven runs, in order. Scores are the agreement line the harness printed for each run:

1. `--limit 3` smoke run: 2/3 (pkg-02 disagreed)
2. `--only pkg-02` (diagnosis, saved with `--out`): 0/1
3. `--only pkg-02,pkg-01,pkg-03,calib-03` (after the first fix; calib-03 is unscored): 3/3
4. First full run: 15/20 (all five misses were clear-accept packages: pkg-05, pkg-08, pkg-11, pkg-13, pkg-19)
5. `--only pkg-05,pkg-08,pkg-11,pkg-13,pkg-19` (diagnosis, saved with `--out`): 0/5
6. `--only` the same five plus six canaries (pkg-04, pkg-07, pkg-10, pkg-14, pkg-01, pkg-20), after the second fix: 11/11
7. Second full run, saved with `--save-run eval-run.txt`: 20/20

The last score in the list, 20/20, matches the agreement line in the committed `eval-run.txt`: `agreement: 20/20 scored items  (bar: 18/20: PASS)`.

**Package analysis**

Package: pkg-11 (BurntSushi/ripgrep#3477, an escaped trailing space in `.gitignore`).

Gold label: `accept`. My rubric's decision: `accept` in the committed run, which agrees. It did not agree at first. In my first full run my rubric graded pkg-11 `reject`, and `test-evidence-observable` was among the failed checks. When I re-graded it with `--only` and `--out`, the grader's evidence line for that check read: "Before/after are '#' notes ('# after: searches normally, no error'), not printed output."

Why my rubric now reads it as accept: the package's test evidence is a command with the observed result written beside it as a comment:

```
$ printf 'foo\\   \n' > .gitignore
$ rg hi                      # before: rg: ./.gitignore: line 1: error
                             # parsing glob 'foo\': dangling '\'
$ rg hi                      # after: searches normally, no error
$ touch 'foo '
$ rg --files                 # after: 'foo ' not listed (ignored),
                             # matching git check-ignore -v 'foo '
```

The before shows the exact error text (`dangling '\'`) and the after shows a different, specific result (the search runs with no error and `foo ` is not listed), which is what the plan's test plan predicted ("no parse error and parity with git on `foo `"). For a command that prints nothing when it succeeds, a concrete observed result in a comment is the evidence there is. My first version of the check required printed output for every claim, so it treated the comment as a bare sentence. I changed the pass condition to say "A concrete observed result written as a comment beside the command counts", and kept the fail condition for a verdict word with no specifics. The package's other claims also hold: its description says "`cargo test -p ignore` passes (214 tests)", it discloses AI use ("Per the repo's AI policy: this change was AI-assisted with me reviewing and understanding every line"), and its diff touches only `crates/ignore/src/gitignore.rs`, the file the plan names.

**Check rationale**

The check as it reads now in `tools/pr-precheck/rubric.md`:

| test-evidence-observable | The decisive proof in the test evidence: the before and after re-run of the repro steps (or the failing-then-passing test) that the plan's test plan names, read against that test plan's expected result. | Pass if the before and the after each show the command or action together with the specific result that was observed (printed output, or for a tool whose result is not a printed table, the concrete values seen: exact error text, exit code, rows, toast text, URL), and the after differs from the before in the way the plan's test plan predicts. A concrete observed result written as a comment beside the command counts. Fail if the decisive proof rests only on a verdict word with no observed specifics ("passes", "works", "fixed", "matches", "unchanged"), on a placeholder such as `[paste output here]`, if before and after cannot be told apart, or if there is no before or no after. Honest output that shows a failure still counts as evidence. Secondary results (a suite or lint summary, a control) are graded under repo-checks-reported and tests-cover-plan, not here. | required |

Why it reads that way: I revised it twice. My first version said "Pass if every result the PR claims is backed by a command together with its actual printed output", so one weak secondary line failed the whole check. That is what happened to pkg-02, a clear-accept package with a strong before and after repro that also had one line, "`pytest tests/ -q` passes (1462 passed, 12 skipped)". In the first revision I narrowed the check to the decisive proof only and moved secondary results to `repo-checks-reported` and `tests-cover-plan`. The second revision came from the five clear-accept misses in the 15/20 run (pkg-08, pkg-11 and pkg-13 failed this check). Their tools do not print a table (a terminal UI in pkg-08, an editor command that opens a browser in pkg-13, a silent success in pkg-11), and gold accepts a concrete observed result in those cases. So I changed "actual printed output" to "the specific result that was observed", and kept the failure for a verdict word with no specifics. I rejected simply deleting the printed-output requirement, because calib-03's evidence, "matches the issue's expected output byte for byte", is exactly a verdict word, and the fail condition still catches that. (calib-03 graded `reject` when I re-ran it after my first revision; I did not re-run it after the second, so for the final wording I rely on the fail condition.)

**Trade-offs**

Loosening this check, together with `tests-cover-plan`, `repo-checks-reported` and `template-complete` in the same revision, changed the result of five packages, and I did not let it go unchecked. Before the confirming full run I re-ran `--only` on the five packages that had disagreed (pkg-05, pkg-08, pkg-11, pkg-13, pkg-19) plus six canaries from the two categories the change could touch: the four `not-tested` packages (pkg-04, pkg-07, pkg-10, pkg-14) and both `standards-wall` packages (pkg-01, pkg-20). The result was 11/11, with all five clear-accept packages now `accept` and all six canaries still `reject`.

What the check gives up: it now accepts a concrete observed result written by hand beside a command, so it cannot tell a pasted output from an invented one. A PR that fabricates a specific value in a comment would pass this check; only a human reading the diff or re-running the repro would catch it. I accept that miss, because the gold labels treat hand-written observed results as evidence for tools that print nothing, and a stricter rule rejected five packages that were ready to submit.
