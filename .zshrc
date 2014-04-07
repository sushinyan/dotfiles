# ~/.zshrc
# sushixnyan <sushixnyan@gmail.com> [2014]

HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -e

zstyle :compinstall filename '/home/trevor/.zshrc'

autoload -Uz compinit
compinit

export LANG="en_US.UTF-8"

autoload -U colors && colors

PROMPT="%{$fg_bold[green]%}┌─%{$reset_color%}[%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%M %{$fg_bold[blue]%}%B%~%b]
%{$fg_bold[green]%}└─╼ %{$reset_color%}"

setopt no_case_glob             # case insensitive globbing
setopt interactivecomments      # ignore lines prefixed with '#'
setopt hist_ignore_dups         # ignore duplicates in history
setopt noflowcontrol            # disable flow control
limit coredumpsize 0            # disable core dumps
setopt RM_STAR_WAIT             # wait 10s before 'rm *' and 'rm path/*'
setopt correctall               # auto correct commands

# command not found hook
source /usr/share/doc/pkgfile/command-not-found.zsh

# path expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# colorize completion
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

# do not complete current directory
zstyle ':completion:*' ignore-parents parent pwd

# bind home and end keys
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line

# aliases
alias ls='ls -x -L -h --color=auto --group-directories-first --ignore=lost+found'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rsync='rsync -av --progress'
alias feh='feh -g 1366x768 -F -Y --auto-zoom'

# pacman aliases
alias pacsyy='sudo pacman -Syy' # force pacman db update
alias pacsyu='sudo pacman -Syu' # update pacman db and upgrade all packages
alias pacs='sudo pacman -S'     # install package from remote repos
alias pacu='sudo pacman -U'     # install package from local file
alias pacr='sudo pacman -Rns'   # remove package, config, and unnecessary dependencies

# function for removing orphaned packages
orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphaned packages!"
    else
        sudo pacman -Rs $(pacman -Qdtq)
    fi
}
