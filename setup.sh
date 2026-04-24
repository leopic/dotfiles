#!/bin/bash

# Function to check if Oh My Zsh is installed
check_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "Oh My Zsh is already installed."
    else
        echo "Oh My Zsh is not installed. Installing now..."
        install_oh_my_zsh
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    if [ $? -eq 0 ]; then
        echo "Oh My Zsh installed successfully."
    else
        echo "There was an error installing Oh My Zsh."
    fi
}

# Function to check if 'z' is installed
check_z() {
    if [ -f "$HOME/cli/z/z.sh" ]; then
        echo "'z' is already installed."
    else
        echo "'z' is not installed. Installing now..."
        install_z
    fi
}

# Function to install 'z' from the repository for Zsh only
install_z() {
    # Create the 'cli' directory if it doesn't exist
    mkdir -p "$HOME/cli"
    
    # Clone 'z' repository into the 'cli' directory
    git clone https://github.com/rupa/z.git "$HOME/cli/z"
    
    # Add 'z' to .zshrc
    echo ". $HOME/cli/z/z.sh" >> "$HOME/.zshrc"
    
    # Source the .zshrc to make 'z' available immediately
    source "$HOME/.zshrc"
    
    if [ $? -eq 0 ]; then
        echo "'z' installed and configured for Zsh successfully."
    else
        echo "There was an error installing or configuring 'z'."
    fi
}

# Function to check if Atuin is installed
check_atuin() {
    if command -v atuin > /dev/null; then
        echo "Atuin is already installed."
    else
        echo "Atuin is not installed. Installing now..."
        install_atuin
    fi
}

# Function to install Atuin using the provided curl command
install_atuin() {
    # Install Atuin via the new method using curl
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    
    # Initialize Atuin for Zsh
    echo 'eval "$(atuin init zsh)"' >> "$HOME/.zshrc"
    
    # Source the .zshrc to make Atuin available immediately
    source "$HOME/.zshrc"
    
    if [ $? -eq 0 ]; then
        echo "Atuin installed and configured for Zsh successfully."
    else
        echo "There was an error installing or configuring Atuin."
    fi
}

# Function to check if NVM is installed
check_nvm() {
    if command -v nvm > /dev/null; then
        echo "NVM is already installed."
    else
        echo "NVM is not installed. Installing now..."
        install_nvm
    fi
}

# Function to install NVM using the official method
install_nvm() {
    # Install NVM via the official installation script
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    
    # Add NVM to .zshrc
    echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> "$HOME/.zshrc"
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> "$HOME/.zshrc"
    
    # Source the .zshrc to make NVM available immediately
    source "$HOME/.zshrc"
    
    if [ $? -eq 0 ]; then
        echo "NVM installed and configured for Zsh successfully."
    else
        echo "There was an error installing or configuring NVM."
    fi
}

check_tmux() {
    if command -v tmux > /dev/null; then
        echo "tmux is already installed."
    else
        echo "Installing tmux..."
        brew install tmux
    fi

    # macOS system Ruby is SIP-protected; use Homebrew Ruby instead
    if ! brew list ruby &>/dev/null; then
        echo "Installing Homebrew Ruby..."
        brew install ruby
    fi

    BREW_GEM="$(brew --prefix ruby)/bin/gem"

    if "$BREW_GEM" list teamocil -i &>/dev/null; then
        echo "teamocil is already installed."
    else
        echo "Installing teamocil..."
        "$BREW_GEM" install teamocil
    fi

    # Ensure Homebrew Ruby bin is on PATH in .zshrc
    RUBY_BIN_LINE='export PATH="$(brew --prefix ruby)/bin:$PATH"'
    if ! grep -qF 'brew --prefix ruby' "$HOME/.zshrc"; then
        echo "$RUBY_BIN_LINE" >> "$HOME/.zshrc"
        echo "Added Homebrew Ruby to PATH in .zshrc — restart your shell or run: source ~/.zshrc"
    fi
}

check_jetbrains_mono() {
    if brew list --cask font-jetbrains-mono &>/dev/null; then
        echo "JetBrains Mono is already installed."
    else
        echo "JetBrains Mono not found. Installing..."
        brew install --cask font-jetbrains-mono
        echo "JetBrains Mono installed — set it in iTerm2 > Profiles > Text > Font."
    fi
}

import_iterm_colors() {
    open "$DOTFILES/argonaut.itermcolors"
    echo "Argonaut iTerm2 colors imported — select it under iTerm2 > Profiles > Colors > Color Presets."
}

link_claude() {
    mkdir -p "$HOME/.claude"
    ln -sf "$DOTFILES/claude/settings.json"  "$HOME/.claude/settings.json"
    ln -sf "$DOTFILES/claude/statusline.sh"  "$HOME/.claude/statusline.sh"
    ln -sf "$DOTFILES/claude/CLAUDE.md"      "$HOME/.claude/CLAUDE.md"
    chmod +x "$DOTFILES/claude/statusline.sh"
    echo "Claude Code config linked."
}

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Run the checks
check_oh_my_zsh
check_z
check_atuin
#check_nvm
check_tmux
link_claude
check_jetbrains_mono
import_iterm_colors

echo "Installation complete! If 'z', 'Atuin', or 'NVM' doesn't work immediately, restart your shell."

