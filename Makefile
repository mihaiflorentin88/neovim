SHELL := /usr/bin/env bash

.PHONY: install-mac install-linux install-tmux-mac install-tmux-linux install-all-mac install-all-linux check scripts-check docs-check tmux-check

install-mac:
	./scripts/install-macos.sh

install-linux:
	./scripts/install-linux.sh

install-tmux-mac:
	./scripts/install-tmux-macos.sh

install-tmux-linux:
	./scripts/install-tmux-linux.sh

install-all-mac:
	./scripts/install-all-macos.sh

install-all-linux:
	./scripts/install-all-linux.sh

scripts-check:
	bash -n scripts/*.sh
	if command -v shellcheck >/dev/null 2>&1; then shellcheck scripts/*.sh; else echo "shellcheck not installed, skipping"; fi

docs-check:
	bash tests/install_docs_test.sh

tmux-check:
	tmux -f tmux.conf start-server \; source-file tmux.conf \; display-message "tmux config loaded" \; kill-server

check: scripts-check docs-check
	nvim --headless README.md "+qa"
	nvim --headless "+checkhealth lazy" "+qa"
