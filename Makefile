.PHONY: brew git gpg mac zsh

brew:
	@./brew/run.sh

git:
	@./git/run.sh

gpg: brew
	@./gpg/run.sh

mac:
	@./mac/run.sh

zsh: brew
	@./zsh/run.sh
