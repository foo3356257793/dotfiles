# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/opt:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export CMAKEPREFIX=-DCMAKE_INSTALL_PREFIX:PATH=$HOME/.local
export C_INCLUDE_PATH=$C_INCLUDE_PATH:$HOME/.local/include
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/.local/include
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/.local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib64:$HOME/.local/lib

autoload -U colors && colors
PROMPT="┌─[%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[yellow]%}%m%{$reset_color%}:%{$fg_bold[red]%}%d%{$reset_color%}]"$'\n'"└─> "

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    z
    colorize
    colored-man-pages
    cp
    per-directory-history
    safe-paste
    vi-mode
    zsh-syntax-highlighting
    #zsh-autosuggestions
)

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ffb8d1"

source $ZSH/oh-my-zsh.sh

export ZSH_COLORIZE_STYLE="colorful"

open() { xdg-open </dev/null &>/dev/null "$@" & }

# better search through previous commands
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# don't remove files by accident
alias rm='safedelete'
function safedelete {
    local -a files
    local force_real=0
    for arg in "$@"; do
        case "$arg" in
            -P|--permanent) force_real=1 ;;
            --) ;;              # end-of-options marker, ignore
            -*) ;;              # ignore rm-style flags (-r -f -rf -i -v ...)
            *) files+=("$arg") ;;
        esac
    done

    (( ${#files} )) || return 0          # nothing to delete

    if (( force_real )); then
        \rm -rf -- "$files[@]"
        return
    fi

    if command -v gio > /dev/null; then
        gio trash -f -- "$files[@]"
    elif command -v gvfs-trash > /dev/null; then
        gvfs-trash "$files[@]"
    elif [ -d "$HOME/.local/share/Trash/files" ]; then
        mv "$files[@]" "$HOME/.local/share/Trash/files"
    else
        \rm -f "$files[@]"
    fi
}

# permanent delete, bypassing trash
function hardrm {
    \rm -rf -- "$@"
}

# # use neovim by default
if command -v nvim >/dev/null 2>&1; then
    export VISUAL="nvim"
    export EDITOR="nvim"
    alias vim="nvim"
    alias vimdiff="nvim -d"
fi
