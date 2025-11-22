.PHONY: atuin brew claude cursor ghostty git gpg mac mise ssh starship vscode zsh

atuin:
	@./atuin/run.sh

brew:
	@./brew/run.sh

claude:
	@./claude/run.sh

cursor:
	@./cursor/run.sh

ghostty:
	@./ghostty/run.sh

git:
	@./git/run.sh

gpg:
	@./gpg/run.sh

mac:
	@./mac/run.sh

mise:
	@./mise/run.sh

.PHONY: organize
organize:
	@chmod +x ./organize/run.sh
	@./organize/run.sh

ssh:
	@./ssh/run.sh

starship:
	@./starship/run.sh

vscode:
	@./vscode/run.sh

zsh:
	@./zsh/run.sh
