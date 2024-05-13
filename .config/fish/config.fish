set -g fish_greeting ''

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux EDITOR nvim

starship init fish | source
zoxide init --cmd cd fish | source

alias ls="eza --color=always --icons=always"
alias cat="bat"
alias dotfiles="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
