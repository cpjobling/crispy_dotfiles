unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="bira"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx ssh-agent vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a Terminal"'
alias v='mvim --remote-silent'
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export PATH=/usr/texbin:/usr/X11/bin:$PATH


fpath=($HOME/.zsh/func $fpath)
typeset -U fpath

alias latexmk='latexmk -pdf -pvc'

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# BDSM 
export PATH="${PATH}:/Users/eechris/.sm/bin:/Users/eechris/.sm/pkg/active/bin:/Users/eechris/.sm/pkg/active/sbin"

# Anaconda
export PATH=/Users/eechris/anaconda/bin:$PATH

plugins=(git bundler brew gem eifion)

export PATH="$HOME/anaconda/bin:$PATH"

# recommended by brew doctor
# eval "$(rbenv init -)"
# DO NOT EDIT BELOW THIS LINE

