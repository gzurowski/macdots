.PHONY: asdf brew git gpg iterm2 mac zsh

asdf:
	@./asdf/run.sh

brew:
	@./brew/run.sh

git:
	@./git/run.sh

gpg: brew
	@./gpg/run.sh

iterm2: brew
	@./iterm2/run.sh

mac:
	@./mac/run.sh

zsh: brew
	@./zsh/run.sh
