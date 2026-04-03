#!/bin/sh

THEME_DIR="$HOME/.config/tmux"
tmux source-file "$THEME_DIR/theme-dark.conf"

# if [ "$(uname)" = "Darwin" ]; then
#     if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ]; then
#         tmux source-file "$THEME_DIR/theme-dark.conf"
#     else
#         tmux source-file "$THEME_DIR/theme-light.conf"
#     fi
# else
#     tmux source-file "$THEME_DIR/theme-dark.conf"
# fi
