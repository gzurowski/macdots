# Functions

# Open the current branch's PR, or the create-PR page if none exists yet.
ghpr() {
    gh pr view --web 2>/dev/null || gh pr create --web
}
