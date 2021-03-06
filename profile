SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initializing new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

alias md5='md5 -r'
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
alias md5sum='md5 -r'
# source /sw/bin/init.sh

# Colorize the Terminal
export CLICOLOR=1
export NODE_PATH="/usr/local/bin/node_modules"

# JRuby
export JRUBY_OPTIONS="--1.9"

# Virtualenv for Python
# source /usr/local/share/python/virtualenvwrapper.sh

# SM
export PATH="${PATH}:/Users/eechris/.sm/bin:/Users/eechris/.sm/pkg/active/bin:/Users/eechris/.sm/pkg/active/sbin"

# Added by Canopy installer on 2014-01-07
# VIRTUAL_ENV_DISABLE_PROMPT can be set to '' to make bashprompt show that Canopy is active, otherwise 1
VIRTUAL_ENV_DISABLE_PROMPT=1 source $HOME/Library/Enthought/Canopy_64bit/User/bin/activate
