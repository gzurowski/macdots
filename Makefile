.PHONY: atuin
atuin:
	@./atuin/run.sh

.PHONY: brew
brew:
	@./brew/run.sh

.PHONY: claude
claude:
	@./claude/run.sh

.PHONY: eza
eza:
	@./eza/run.sh

.PHONY: firefox
firefox:
	@./firefox/run.sh

.PHONY: ghostty
ghostty:
	@./ghostty/run.sh

.PHONY: git
git:
	@./git/run.sh

.PHONY: gpg
gpg:
	@./gpg/run.sh

.PHONY: mac
mac:
	@./mac/run.sh

.PHONY: mise
mise:
	@./mise/run.sh

.PHONY: organize
organize:
	@chmod +x ./organize/run.sh
	@./organize/run.sh

.PHONY: ssh
ssh:
	@./ssh/run.sh

.PHONY: starship
starship:
	@./starship/run.sh

.PHONY: vscode
vscode:
	@./vscode/run.sh

.PHONY: zsh
zsh:
	@./zsh/run.sh
