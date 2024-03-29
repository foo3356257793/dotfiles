# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/opt:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export CMAKEPREFIX=-DCMAKE_INSTALL_PREFIX:PATH=$HOME/.local
export C_INCLUDE_PATH=$C_INCLUDE_PATH:$HOME/.local/include
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/.local/include
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/.local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib64:$HOME/.local/lib

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

autoload -U colors && colors
PROMPT="┌─[%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[yellow]%}%m%{$reset_color%}:%{$fg_bold[red]%}%d%{$reset_color%}]"$'\n'"└─> "

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export ZSH_COLORIZE_STYLE="colorful"
# open() { zathura </dev/null &>/dev/null "$@" & }
open() { evince </dev/null &>/dev/null "$@" & }

# better search through previous commands
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# fzf config
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
#export FZF_DEFAULT_COMMAND='/home/dad/opt/list_files_in_dir.py'
#export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

#export FZF_ALT_C_COMMAND="ag --ignore '.git' -g ."
#export FZF_ALT_C_COMMAND="/home/dad/opt/list_all_directories.py"

source /usr/share/fzf/shell/key-bindings.zsh

# don't remove files by accident
alias rm='safedelete'
function safedelete {
    if command -v gio > /dev/null; then
        for f in "$@"
        do
            gio trash -f "$f"
        done

    elif command -v gvfs-trash > /dev/null; then
        for f in "$@"
        do
            gvfs-trash "$f"
        done

    elif [ -d "$HOME/.local/share/Trash/files" ]; then
        for f in "$@"
        do
            mv "$f" "$HOME/.local/share/Trash/files"
        done

    else
        for f in "$@"
        do
            # shellcheck disable=SC1012
            \rm "$f"
        done
    fi
}

