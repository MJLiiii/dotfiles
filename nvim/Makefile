NVIM ?= nvim
STYLUA ?= $(shell command -v stylua 2>/dev/null || printf '%s' "$(HOME)/.local/share/nvim/mason/bin/stylua")
SELENE ?= $(shell command -v selene 2>/dev/null || printf '%s' "$(HOME)/.local/share/nvim/mason/bin/selene")

.PHONY: check format format-check lint smoke

check: format-check lint smoke

format:
	$(STYLUA) .

format-check:
	$(STYLUA) --check .

lint:
	$(SELENE) .

smoke:
	$(NVIM) --headless -i NONE -u init.lua '+qa!'
