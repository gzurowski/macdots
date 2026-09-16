# Gregor's AGENTS.md

## Code style

- Keep nesting shallow. Use guard clauses with early `return`, and `continue`/`break` in loops, to handle edge cases first — avoid the Arrow Anti-Pattern (deeply nested conditionals). The main logic should sit at the base indentation level.

## Tests

- Do not create tombstone tests that verify removed functionality is gone (e.g. asserting a deleted function, endpoint, or field no longer exists). When functionality is removed, delete its tests too rather than adding tests that assert its absence.
