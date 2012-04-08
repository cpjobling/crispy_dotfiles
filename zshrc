# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="robbyrussell"

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
export PATH=:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin::/usr/texbin:/usr/X11/bin


# load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

fpath=($HOME/.zsh/func $fpath)
typeset -U fpath

alias latexmk='latexmk -pdf -pvc'
