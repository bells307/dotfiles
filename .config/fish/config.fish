set -g fish_greeting ''

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux EDITOR hx

starship init fish | source
zoxide init --cmd cd fish | source
eval (tmuxifier init - fish)

alias ls="eza --color=always --icons=always"
alias cat="bat"
alias dotfiles="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
