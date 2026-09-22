# Gregor's AGENTS.md

## Code style

- Keep nesting shallow. Use guard clauses with early `return`, and `continue`/`break` in loops, to handle edge cases first — avoid the Arrow Anti-Pattern (deeply nested conditionals). The main logic should sit at the base indentation level.
- Keep comments short and concise. Don't restate in prose what the code already says — comment only when it adds value: the non-obvious "why", intent, or caveats.

## Tests

- Do not create tombstone tests that verify removed functionality is gone (e.g. asserting a deleted function, endpoint, or field no longer exists). When functionality is removed, delete its tests too rather than adding tests that assert its absence.
- Do not write tests that verify behavior owned by a third-party library or framework (e.g. that gzip middleware actually compresses responses, or that an ORM persists a row). Assume dependencies work as documented; test only your own code and the non-trivial logic in how it wires or configures them.
