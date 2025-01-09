# vim mode
set -o vi

if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
else
    echo "install starship for pretty commandline"
fi


alias python=python3

# for fast config editing
alias neovim="cd ~/.config/nvim/"

# open files from the commandline as if there being double clicked
alias open="xdg-open"

# inside joke
alias andi="ping 8.8.8.8"

