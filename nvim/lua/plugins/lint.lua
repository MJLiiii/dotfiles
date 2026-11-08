-- Lint on BufEnter/BufWritePost/InsertLeave (nvim-lint); linters are installed by mason-nvim-lint
-- from the table below. Mason itself is configured in lua/plugins/mason.lua.
return {
	"mfussenegger/nvim-lint",
	-- BufReadPost (lsp/conform use BufReadPre): no practical difference here, BufEnter still
	-- fires afterwards for the first file.
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"mason-org/mason.nvim",
		-- opts = {} is load-bearing: lazy only calls setup() when opts/config is present, and
		-- setup() is what auto-installs every linter named below (automatic_installation = true
		-- is the default).
		{ "rshkarin/mason-nvim-lint", opts = {} },
	},
	-- `config`, not `opts`: nvim-lint has no setup(); linters_by_ft is assigned directly.
	config = function()
		local lint = require("lint")
		-- selene reads selene.toml from its cwd only (no upward search) and nvim-lint runs it from Nvim's
		-- cwd, so opening ~/dotfiles instead of ~/dotfiles/nvim would silently lose this config's
		-- selene.toml (selene then flags every `vim`). Resolve the nearest selene.toml above the buffer on
		-- each run instead; buffers without one keep the upstream args, i.e. today's behaviour. nvim-lint
		-- accepts a linter given as a function and calls it per run with the linted buffer current.
		-- require() the definition directly: that is all lint.linters' __index does, and reading the field
		-- here would make lua_ls type it as the function assigned below.
		local selene = require("lint.linters.selene")
		lint.linters.selene = function()
			local root = vim.fs.root(0, "selene.toml")
			return vim.tbl_extend("force", selene, {
				args = root and vim.list_extend({ "--config", root .. "/selene.toml" }, selene.args) or selene.args,
			})
		end

		lint.linters_by_ft = {
			lua = { "selene" },
			python = { "ruff" },
			javascript = { "eslint_d" },
			markdown = { "markdownlint" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			vim = { "vint" },
			tex = { "proselint" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("user_lint", { clear = true }),
			desc = "Run nvim-lint for the current buffer",
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
