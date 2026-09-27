# Voice guide: how I talk upstream

<!--
THIS IS THE PART YOU WRITE (new this week). Live mode reads this file
before any comment of yours goes out the door; eval mode ignores it
entirely, because your voice is yours and carries no gold labels.

This is not etiquette. "Be polite and concise" is advice for everyone
and therefore rules for no one. Write rules YOU need, in your own
words, each one concrete enough that the skill can hold a draft
against it and say which rule it breaks.

Three sections. Fill all three.
-->

## Who I am in threads

I'm a student contributing to this repo as part of a course project,
not a maintainer or an experienced OSS contributor yet. I'm here to
investigate and report clearly, not to promise fixes or timelines.
Readers should expect a specific, evidenced comment from me — never a
vague "I'll look into it" with nothing to back it up.

## Rules I write by

### Rule: promise, don't assert

A claim comment says what I'm about to investigate, never that I've
already fixed or fully confirmed something I haven't reproduced yet.

- Wrong: "I'll have this fixed shortly."
- Right: "I'm picking this up and will report back with a
  reproduction and my findings."

### Rule: name specifics, not templates

Every comment names this issue's actual input/command/behavior instead
of a generic phrase that could paste onto any issue.

- Wrong: "I can confirm this bug happens."
- Right: "Running the scrubber on `(602) 555-0173` leaves the number
  un-redacted; the regex only matches the unparenthesized format."

### Rule: state uncertainty as uncertainty

If something is unclear or only partially reproduced, I say that
plainly instead of rounding up to a confident verdict.

- Wrong: "This confirms the reported bug is present and reproducible."
- Right: "I reproduced a failure with this input, but I haven't yet
  ruled out that it's a different bug than the one reported — still
  checking the panic signature against the issue."

### Rule: disclose AI assistance when the repo asks for it

If the repo's contribution policy requires disclosing AI assistance,
my comment says so plainly, in its own sentence, not buried or omitted.

- Wrong: (omitting it entirely)
- Right: "Drafted with AI assistance (Claude Code), reviewed and run
  by me before posting."

## Things I never post

- A fix timeline or "I'll have a PR up by [date]."
- "Same as above, can confirm" on a shared/house issue — my proof goes
  up in my own words even if someone else already commented.
- A confident conclusion when my evidence only shows an adjacent or
  different failure than the one reported.
- Any comment I haven't first run through repro-check in live mode.
