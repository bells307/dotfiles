#!/usr/bin/env bash

set -e

dirs=(
    "$HOME/.cache/nvim"
    "$HOME/.local/state/nvim"
)

for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        rm -rf "$dir"
        echo "$dir"
    fi
done

