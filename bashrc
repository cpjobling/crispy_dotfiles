alias migrate='rake db:migrate && rake db:test:prepare'

source ~/bin/dotfiles/bashrc
source ~/.git-completion.bash


export GEM_HOME='/usr/local'
[[ -s "/Users/eechris/.rvm/scripts/rvm" ]] && source "/Users/eechris/.rvm/scripts/rvm" 


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
