#!/bin/bash

# Update and install Zsh if not installed
if ! command -v zsh &> /dev/null; then
    echo "Zsh not found. Installing..."
    sudo pacman -S zsh
else
    echo "Zsh is already installed."
fi

# Install zsh-syntax-highlighting
if [ ! -d "/usr/share/zsh/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    sudo pacman -S zsh-syntax-highlighting
fi

# Create or overwrite .zshrc file
cat << 'EOF' > ~/.zshrc
# Source syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ls="ls -a --color"
alias lsd="lsd -a"
alias cls="clear"
alias gdebug="GTK_DEBUG=interactive"

# Keybindings
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "\e[3~" delete-char
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# Prompt settings
autoload -U promptinit; promptinit
PURE_PROMPT_SYMBOL="❯❯❯"
prompt pure

# Set the default editor
export EDITOR=nano

# Command history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Load custom scripts
if [ -f ~/.zshrc_custom ]; then
    source ~/.zshrc_custom
fi

# Set terminal title
case $TERM in
    xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
esac

# Welcome message
echo "Welcome back, $USER! Happy coding!"

# Enable auto-completion
autoload -Uz compinit
compinit
EOF

echo ".zshrc has been created. Please restart your terminal or run 'source ~/.zshrc' to apply the changes."
