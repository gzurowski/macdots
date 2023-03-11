.PHONY: brew git gpg zsh

brew:
	@./brew/run.sh

git:
	@./git/run.sh

gpg: brew
	@./gpg/run.sh

zsh: brew
	@./zsh/run.sh
