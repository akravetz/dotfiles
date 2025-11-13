#!/bin/bash
# install.sh

# Check if oh-my-zsh is already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  # Use the --unattended flag for non-interactive install
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
else
  echo "Oh My Zsh is already installed."
fi
