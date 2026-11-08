-- LSP servers. This file owns the server lists: mason installs and enables `mason_servers`, while
-- `external_servers` contains servers installed outside mason and enabled by config(). Lean is
-- handled entirely by lean.nvim (see lean.lua).
--
-- Per-server overrides live in after/lsp/<name>.lua, deep-merged on top of nvim-lspconfig's
-- lsp/<name>.lua (per key, so upstream keys you do not mention survive); an explicit
-- vim.lsp.config(name, ...) call still wins over both. An after/lsp file is optional only for
-- servers nvim-lspconfig ships -- for any other server it is the whole config.
--
-- Language policy: servers only where I actually develop (lua, c/cpp, python, haskell, rocq,
-- lean); conform/lint cover more filetypes because formatting and linting are cheap to add;
-- treesitter.lua states its own parser rule.

-- Keep both lists here so adding a language does not require editing the setup logic.
local mason_servers = { "lua_ls", "clangd", "pyright" }
local external_servers = { "vsrocq", "hls" }

return {
	"mason-org/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- Shared Mason setup lives in mason.lua; conform.lua and lint.lua use it too.
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
	},
	opts = {
		ensure_installed = mason_servers,
		-- automatic_enable defaults to enabling every *installed* mason package, not just
		-- the list above, so leftover servers would keep attaching. Pin it to an allowlist.
		automatic_enable = mason_servers,
	},
	-- blink.cmp is a dependency so it is loaded at all: it is lazy = true with no trigger of its
	-- own, and vim.lsp.config("*") must carry its capabilities before any client starts. Ordering
	-- relative to vim.lsp.enable() below is not critical -- enable() caches nothing, and a later
	-- vim.lsp.config("*") invalidates every resolved config. BufReadPre still precedes the
	-- FileType event that vim.lsp.enable() hooks for the same buffer.
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
		-- vsrocqtop comes from opam; haskell-language-server-wrapper comes from ghcup.
		-- Neither is a mason package. See after/lsp/{vsrocq,hls}.lua.
		vim.lsp.enable(external_servers)
	end,
}
