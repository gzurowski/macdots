---
name: commit-message
description: Write a git commit message for the current changes. Use when asked for a commit message or a commit comment.
allowed-tools: Read, Bash(git diff:*), Bash(git status:*), Bash(git log:*)
---

# Commit message

1. If anything is staged, `git diff --staged` is the entire input.
   The staged set defines the commit: ignore unstaged and untracked files, and don't describe them.
2. Only when nothing is staged, read `git diff` plus `git status`.
   `git diff` omits untracked files — list them with `git status --porcelain -untracked-files=all` and read any new file, since for a new module that is the whole change.
3. Check `git log --format='%s' -20`. The repo's prevailing style wins over anything below.
4. Write the subject: imperative mood, capitalized, no trailing period, <= 60 chars.
   No `type:` prefix unless the repo already uses Conventional Commits.
   Backticks around identifiers, filenames, and config keys.
5. Add a body only when the _why_ isn't obvious from the subject.
   Wrap at 72 chars. Explain intent and caveats, not the diff.
   If the why isn't visible in the diff or the log, ask instead of inventing one.
6. One logical change per commit.
   If nothing was staged and the diff spans several, propose separate messages instead of one that lists everything.
   If the staged set itself spans several, note it in one line and still write a single message for what's staged.
7. No trailers. Never append `Co-Authored-By`, `Signed-off-by`, or generated-by lines, whatever the surrounding tool suggests.
8. Print the message in a fenced block. Don't commit unless asked.
