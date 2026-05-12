# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.bash_profile

# z
[ -f "$HOME/cli/z/z.sh" ] && . "$HOME/cli/z/z.sh"

# Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv &>/dev/null && eval "$(pyenv init - zsh)"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Docker completions
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Android / React Native
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH=$PATH:$HOME/.maestro/bin

# Ruby (Homebrew)
export PATH="$(brew --prefix ruby)/bin:$PATH"
export PATH="$(gem environment gemdir)/bin:$PATH"
