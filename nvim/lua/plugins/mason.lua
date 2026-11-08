-- Shared package management for LSP servers, formatters and linters. The dependent specs in
-- lsp.lua, conform.lua and lint.lua ensure Mason loads before their setup functions run.
return {
	"mason-org/mason.nvim",
	-- mason.nvim creates its commands in setup() and ships no plugin/ directory. Declaring cmd
	-- here keeps :Mason available before the first file triggers any dependent tooling.
	cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
	opts = {},
}
