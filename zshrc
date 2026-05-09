export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile

# z
. /Users/leo/cli/z/z.sh

# Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

. "$HOME/.local/bin/env"

# Docker completions
fpath=(/Users/leo/.docker/completions $fpath)
autoload -Uz compinit
compinit

# bun
[ -s "/Users/leo/.bun/_bun" ] && source "/Users/leo/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Android / React Native
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Antigravity
export PATH="/Users/leo/.antigravity/antigravity/bin:$PATH"
export PATH=$PATH:$HOME/.maestro/bin

# Ruby (Homebrew)
export PATH="$(brew --prefix ruby)/bin:$PATH"
export PATH="$(gem environment gemdir)/bin:$PATH"
