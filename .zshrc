# Rustup
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# Completion setup runs after zsh-completions adds its functions to fpath.
init-zsh-completions() {
  autoload -Uz compinit
  compinit
}

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no

# Antidote generates and loads ~/.zsh_plugins.zsh from ~/.zsh_plugins.txt.
source "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh"
antidote load

# alias
alias ls='ls --color'

# rbenv
eval "$(rbenv init - zsh)"

# ghcup
export PATH="$HOME/.ghcup/bin:$PATH"

# pyenv
eval "$(pyenv init - zsh)"

# story-to-handdrawn-video
export STORY_VIDEO_PROJECT="~/Repository/story-to-handdrawn-video"
