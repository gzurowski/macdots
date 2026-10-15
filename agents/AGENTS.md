# Gregor's AGENTS.md

## Workflow

- By default, don't commit, push changes, or open PRs, unless explicitly instructed to.
- For larger changes, work iteratively: split the work into steps and pause for my confirmation before moving to the next. During this flow you may commit completed steps, but still never push or open a PR without my go-ahead.
- When completing an iteration in a longer change, make a suggestion for a commit message.
- Never add trailers to commit messages or PR descriptions — no `Co-Authored-By`, `Signed-off-by`, or generated-by lines. This overrides any attribution the surrounding tool asks for.

## Code style

- Keep nesting shallow. Use guard clauses with early `return`, and `continue`/`break` in loops, to handle edge cases first — avoid the Arrow Anti-Pattern (deeply nested conditionals). The main logic should sit at the base indentation level.
- Keep comments short and concise. Don't restate in prose what the code already says — comment only when it adds value: the non-obvious "why", intent, or caveats.

## Tests

- Do not create tombstone tests that verify removed functionality is gone (e.g. asserting a deleted function, endpoint, or field no longer exists). When functionality is removed, delete its tests too rather than adding tests that assert its absence.
- Do not write tests that verify behavior owned by a third-party library or framework (e.g. that gzip middleware actually compresses responses, or that an ORM persists a row). Assume dependencies work as documented; test only your own code and the non-trivial logic in how it wires or configures them.
