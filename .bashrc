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
else
    echo "install starship for pretty commandline"
    # cool PS1
    # --- Git ---
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
    }

    show_git_branch() {
        if [ ! -z "$(parse_git_branch)" ]; then
            echo -e "\001\033[48;5;8;38;5;29m\002\033[38;5;29;48;5;64m\ue0b0\001\033[0m\002\001\033[0;48;5;64m\002 \u2e19 $(parse_git_branch) \001\033[0m\002\001\033[0;38;5;64m\002\ue0b0\001\033[0m\002 "
        else
            echo -e "\001\033[38;5;29m\002\ue0b0\001\033[0m\002 "
        fi
    }

    show_git_status() {
        if ! git rev-parse --git-dir > /dev/null 2>&1; then
            return
        fi

        local git_status_string=""
        if [ -n "$(git ls-files --others --exclude-standard)" ]; then
            git_status_string="${git_status_string}?"
        fi

        if ! git diff --quiet; then
            git_status_string="${git_status_string}!"
        fi

        if ! git diff --cached --quiet; then
            git_status_string="${git_status_string}+"
        fi

        if git stash list | grep -q .; then
            git_status_string="${git_status_string}$"
        fi

        if git status | grep -q "branch is ahead of"; then
            git_status_string="${git_status_string}⇡"
        fi

        if [ ! -z $git_status_string ]; then
            # red text color
            echo -n -e "\033[31m"
            # print status
            echo -n -e "[$git_status_string]"
            # reset color
            echo -e "\033[00m "
        fi
    }
    # ---

    # --- Time ---
    function set_ps1_starttime() {
        declare -g ps1_starttime=$(date +%s)
        touch /tmp/ps1_starttime_start
    }
    trap set_ps1_starttime DEBUG

    show_time_taken() {
        if [ ! -f /tmp/ps1_starttime_start ]; then
            return
        else
            rm /tmp/ps1_starttime_start
        fi

        declare -g ps1_endtime=$(date +%s)
        local difference=$((ps1_endtime - ps1_starttime))

        if [ $difference -gt 0 ]; then
            local hours=$((difference / 3600))
            local minutes=$(((difference - (hours * 3600)) / 60))
            local seconds=$((difference - (hours * 3600) - (minutes * 60)))

            echo -n -e "\033[33mtook "

            if [ $hours -gt 0 ]; then
                echo -n "$((hours))h "
            fi

            if [ $minutes -gt 0 ]; then
                echo -n "$((minutes))min "
            fi

            if [ $seconds -gt 0 ]; then
                echo -n "$((seconds))s"
            fi

            echo -e "\033[00m"
        fi
    }
    # ---
    PS1='\n\[\033[0;48;5;29m\] \w \[\033[0m\]$(show_git_branch)$(show_git_status)$(show_time_taken)\n > '
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
