# vim mode
set -o vi

# set sudoedit editor
if command -v neovim &> /dev/null; then
    export EDITOR=nvim
elif command -v vim &> /dev/null; then
    export EDITOR=vim
elif command -v vi &> /dev/null; then
    export EDITOR=vi
fi

# starship init
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
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

# git aliases
alias gs="git status"
alias gss="git status -s"
alias ga="git add"
alias gap="git add --patch"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --graph --all --pretty=format:'%C(blue)%h %C(white) %an  %ar%C(green)  %D%n%s%n'"
alias gc="git commit"

# helper
alias eit="exit"
alias exi="exit"
alias eixt="exit"
alias ext="exit"
alias eixtt="exit"

convert_videos() {
    for i in *; do ffmpeg -i "$i" -c:v libx264 -c:a aac -y "$i.mp4"; done
}
