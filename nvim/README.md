# Neovim

Neovim 0.12 config managed by [lazy.nvim](https://github.com/folke/lazy.nvim); plugin versions are
pinned in `lazy-lock.json`.

## Requirements

Language servers, formatters and linters are installed by mason (`:Mason`). The tools below are not
mason packages and must be on `PATH`:

| Tool | Used by | Install |
|---|---|---|
| `tree-sitter` CLI ≥ 0.26.1 | nvim-treesitter parser builds | `brew install tree-sitter-cli` |
| `vsrocqtop` | Rocq/Coq LSP (`after/lsp/vsrocq.lua`) | opam |
| `haskell-language-server-wrapper` + matching `haskell-language-server-<ghc>` | Haskell LSP (`after/lsp/hls.lua`) | ghcup |
| `lake` | Lean 4 LSP via lean.nvim (`lake serve`) | elan |
| `lazygit` | `<leader>gg` | brew |
| `gh` | `<leader>gi` / `gI` / `gp` / `gP` | brew |
| `rg` | grep pickers | brew |
| `rustfmt` | Rust formatting | rustup |

## Layout

| Path | Contents |
|---|---|
| `init.lua` | leader keys, then `core.options` → `core.keymaps` → `core.autocmds` → `core.lazy` |
| `lua/core/` | editor options, plugin-independent keymaps and autocmds |
| `lua/plugins/` | one lazy.nvim spec per plugin; a plugin's keymaps live in its spec |
| `after/lsp/<server>.lua` | per-server overrides, deep-merged on top of nvim-lspconfig's defaults |

Formatting: `.stylua.toml` (tabs, 120 columns). Run `stylua .` with the mason-installed binary in
`~/.local/share/nvim/mason/bin/`.

Linting: `selene.toml` + `vim.yml`. Run `selene .` from this directory: selene reads its config from
the cwd only, so `lua/plugins/lint.lua` passes `--config` for you inside Neovim.

## Keymap prefixes

`<leader>` is Space, `<LocalLeader>` is `\`. Pause 300 ms after a prefix for the mini.clue hint
window; `<leader>sk` lists every mapping with its description.

| Prefix | Group |
|---|---|
| `<leader>f` | find files / buffers / recent |
| `<leader>s` | search or list anything (snacks pickers) |
| `<leader>g` | git and GitHub |
| `<leader>c` | code: action, format, symbols, call hierarchy |
| `<leader>x` | trouble lists |
| `<leader>u` | UI toggles, notifications, colorschemes |
| `g*` | LSP navigation (`gd`, `gD`, `gr`, `gI`, `gy`) |
| `s*` | window splits (`sv`, `sh`, `sc`, `so`); `st` turns the window into a `:terminal` |
| `<C-hjkl>` | window focus, from terminal-mode too; `<C-arrows>` resize |
| `<C-/>` / `<C-_>` | toggle the right / bottom terminal; `<Esc><Esc>` leaves terminal-mode |
| `<LocalLeader>` | lean.nvim in Lean buffers |
