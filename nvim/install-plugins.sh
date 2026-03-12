#!/bin/sh
set -e

PACK_DIR="$HOME/.local/share/nvim/site/pack/plugins/start"
mkdir -p "$PACK_DIR"

clone_or_pull() {
    local repo="$1"
    local dir="$2"
    local branch="${3:-}"

    if [ -d "$PACK_DIR/$dir" ]; then
        echo "Updating $dir..."
        git -C "$PACK_DIR/$dir" pull --ff-only
    else
        echo "Installing $dir..."
        if [ -n "$branch" ]; then
            git clone --depth=1 --branch "$branch" "https://github.com/$repo" "$PACK_DIR/$dir"
        else
            git clone --depth=1 "https://github.com/$repo" "$PACK_DIR/$dir"
        fi
    fi
}

clone_or_pull "nvim-lua/plenary.nvim" "plenary.nvim"
clone_or_pull "rebelot/kanagawa.nvim" "kanagawa.nvim"
clone_or_pull "folke/tokyonight.nvim" "tokyonight.nvim"
clone_or_pull "catppuccin/nvim" "catppuccin"
clone_or_pull "Mofiqul/vscode.nvim" "vscode.nvim"
clone_or_pull "projekt0n/github-nvim-theme" "github-nvim-theme"
clone_or_pull "sainnhe/everforest" "everforest"
clone_or_pull "windwp/nvim-autopairs" "nvim-autopairs"
clone_or_pull "stevearc/conform.nvim" "conform.nvim"
clone_or_pull "saecki/crates.nvim" "crates.nvim"
clone_or_pull "folke/flash.nvim" "flash.nvim"
clone_or_pull "smoka7/hop.nvim" "hop.nvim"
clone_or_pull "lewis6991/gitsigns.nvim" "gitsigns.nvim"
clone_or_pull "stevearc/oil.nvim" "oil.nvim"
clone_or_pull "nvim-telescope/telescope.nvim" "telescope.nvim"
clone_or_pull "nvim-telescope/telescope-ui-select.nvim" "telescope-ui-select.nvim"

if [ -d "$PACK_DIR/telescope-fzf-native.nvim" ]; then
    echo "Updating telescope-fzf-native.nvim..."
    git -C "$PACK_DIR/telescope-fzf-native.nvim" pull --ff-only
else
    echo "Installing telescope-fzf-native.nvim..."
    git clone --depth=1 "https://github.com/nvim-telescope/telescope-fzf-native.nvim" \
        "$PACK_DIR/telescope-fzf-native.nvim"
    echo "Building telescope-fzf-native.nvim..."
    make -C "$PACK_DIR/telescope-fzf-native.nvim"
fi

clone_or_pull "nvim-treesitter/nvim-treesitter" "nvim-treesitter" "main"
clone_or_pull "nvim-treesitter/nvim-treesitter-textobjects" "nvim-treesitter-textobjects" "main"
clone_or_pull "nvim-treesitter/nvim-treesitter-context" "nvim-treesitter-context"

echo ""
echo "Done. Open Neovim and run :TSUpdate to install parsers."
