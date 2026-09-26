# snuffred's dotfiles

Personal development configs for macOS, centered on Neovim, Zsh, and keyboard-driven window management. The shell setup assumes Apple Silicon Homebrew paths, with some Linuxbrew support in `.zprofile`.

## What's included

| Config | Purpose |
| --- | --- |
| [`.zshrc`](.zshrc) | Zinit plugins, Spaceship prompt, syntax highlighting, autosuggestions, and language toolchain paths |
| [`.zprofile`](.zprofile) | Homebrew environment, pyenv, elan, and optional OrbStack integration |
| [`nvim/`](nvim/) | Modular Neovim configuration managed by lazy.nvim |
| [`ghostty/config`](ghostty/config) | Ghostty with Rosé Pine Dawn, FiraCode Nerd Font, and a hidden macOS title bar |
| [`.tmux.conf`](.tmux.conf) | Tmux with a `Ctrl-s` prefix, mouse support, and a top status bar |
| [`.aerospace.toml`](.aerospace.toml) | AeroSpace tiling, Vim-style navigation, and numbered workspaces |
| [`.vimrc`](.vimrc) | Lightweight Vim settings and split-navigation mappings |
| [`.ideavimrc`](.ideavimrc) | Line numbers and `jk` to leave insert mode in JetBrains IDEs |
| [`.gitconfig`](.gitconfig) | Personal Git identity and GitHub CLI credential helpers |

## Setup

### 1. Install dependencies

Install [Homebrew](https://brew.sh/) and Apple's Command Line Tools if needed (`xcode-select --install`), then install the tools for the configs you intend to use:

```sh
brew install neovim tmux rbenv pyenv ripgrep tree-sitter-cli lazygit gh
brew install --cask ghostty font-fira-code-nerd-font
brew install --cask nikitabobko/tap/aerospace
```

The Neovim config targets **Neovim 0.12** and requires **tree-sitter CLI 0.26.1 or newer**. Check `nvim --version` and `tree-sitter --version` after installation; use a suitable Neovim build if your Homebrew version is older.

Language-specific tools such as Rust, GHCup, elan, and Rocq/Coq need separate installation. See the [Neovim requirements](nvim/README.md#requirements) for the full list.

### 2. Clone and personalize

```sh
git clone https://github.com/snuffred/dotfiles.git ~/dotfiles
```

Review these machine-specific settings before linking:

- **Shell:** `.zshrc` initializes `rbenv` and `pyenv`, adds Rust, Julia, and GHCup paths, and includes an absolute Antigravity IDE path. `.zprofile` adds elan and Homebrew paths. Adjust them for your installed toolchains and home directory.
- **Monitors:** `.aerospace.toml` assigns workspace `1` to `279p1` and workspace `3` to `Built-in`. Update or remove those assignments for your displays.
- **Git:** `.gitconfig` contains my name and email, and credential helpers pointing to `/home/linuxbrew/.linuxbrew/bin/gh`. Set your own identity and helper path if you use it.

### 3. Link the configs

Move any existing destination files or directories to a backup location first. Run only the links for the tools you want to configure; these commands assume the default `~/.config` location.

```sh
mkdir -p ~/.config

ln -s ~/dotfiles/.zprofile ~/.zprofile
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/ghostty ~/.config/ghostty
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.aerospace.toml ~/.aerospace.toml
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.ideavimrc ~/.ideavimrc
```

After personalizing `.gitconfig`, you can link it too:

```sh
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
```

### 4. Start the tools

- Open a new login shell. Zinit installs itself and loads the configured plugins on first launch, which requires network access.
- Launch `nvim`. The config bootstraps lazy.nvim; let plugin installation finish, then use `:Mason` to inspect managed tools and `:checkhealth` to check the environment.
- Launch Ghostty and AeroSpace. Grant AeroSpace Accessibility access when prompted so it can manage windows.
- Start a new `tmux` session, or reload an existing one with `tmux source-file ~/.tmux.conf`.

## Neovim

The editor uses small, per-plugin modules with versions pinned in `nvim/lazy-lock.json`:

- **Completion and LSP:** blink.cmp, nvim-lspconfig, and Mason, with per-server overrides in `after/lsp/`.
- **Formatting and linting:** conform.nvim and nvim-lint.
- **Navigation and UI:** snacks.nvim pickers, trouble.nvim lists, and mini.nvim utilities and key hints.
- **Syntax and language support:** nvim-treesitter and lean.nvim.
- **Theme:** Rosé Pine Dawn, shared with Ghostty.

See [`nvim/README.md`](nvim/README.md) for tool requirements, directory layout, formatting and linting commands, and keymap groups.

## Keybindings

### Editors

Neovim and Vim use **Space** as the leader key. Neovim's local leader is **backslash** (`\`).

| Keys | Action | Where |
| --- | --- | --- |
| `jk` in insert mode | Return to normal mode | Neovim, Vim, IdeaVim |
| `Ctrl-h/j/k/l` | Focus the left/down/up/right split | Neovim, Vim |
| `sv` / `sh` | Split vertically / horizontally | Neovim, Vim |
| `sc` / `so` | Close the current split / other splits | Neovim, Vim |
| `Ctrl` + arrow keys | Resize splits | Neovim, Vim |
| `<leader>nh` | Clear search highlighting | Neovim, Vim |
| `<leader>sk` | List keymaps | Neovim |
| `<leader>l` | Open lazy.nvim | Neovim |

### Tmux

Use **`Ctrl-s`** as the prefix. Press **`Ctrl-s`, then `r`** to reload `.tmux.conf`.

### AeroSpace

`Alt` corresponds to the **Option** key on macOS.

| Keys | Action |
| --- | --- |
| `Alt-h/j/k/l` | Focus the left/down/up/right window |
| `Alt-Shift-h/j/k/l` | Move the current window |
| `Alt-1` through `Alt-9` | Switch workspace |
| `Alt-Shift-1` through `Alt-Shift-9` | Move the current window to a workspace |
| `Alt-/` / `Alt-,` | Switch tile / accordion layout orientation |
| `Alt-Shift--` / `Alt-Shift-=` | Shrink / grow the current window |
| `Alt-Ctrl-f` | Toggle fullscreen |
| `Alt-Tab` | Switch to the previous workspace |
| `Alt-Shift-Tab` | Move the workspace to the next monitor |
| `Alt-Shift-;` | Enter service mode |

In service mode, `Esc` reloads the config, `r` resets the layout, and `f` toggles floating/tiling; each returns to the main mode. See [`.aerospace.toml`](.aerospace.toml) for all bindings.
