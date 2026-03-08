#!/bin/sh
# Append ZDOTDIR to ~/.zshenv if not already set
if grep -q 'ZDOTDIR' "$HOME/.zshenv" 2>/dev/null; then
    echo "ZDOTDIR already set in ~/.zshenv, skipping."
else
    echo 'export ZDOTDIR="$HOME/.config/zsh"' >> "$HOME/.zshenv"
    echo "Appended ZDOTDIR to ~/.zshenv."
fi
