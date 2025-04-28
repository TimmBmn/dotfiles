# vim mode
set -o vi

# starship init
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
else
    echo "install starship for pretty commandline"
fi

# fzf init
if command -v fzf &> /dev/null; then
    eval "$(fzf --bash)"
    # Open in tmux popup if on tmux, otherwise use --height mode
    export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border'
else
    echo "fzf is not installed"
fi

alias python=python3

# for fast config editing
alias neovim="cd ~/.config/nvim/"

# open files from the commandline as if there being double clicked
alias open="xdg-open"

# inside joke
alias andi="ping 8.8.8.8"

