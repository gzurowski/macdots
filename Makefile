.PHONY: brew git zsh

brew:
	@./brew/run.sh

git:
	@./git/run.sh

zsh: brew
	@./zsh/run.sh
