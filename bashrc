export ENVSETUP="${HOME}/.envsetup"
[[ -f ${ENVSETUP}/bashrc-common && -n "${PS1}" ]] && . ${ENVSETUP}/bashrc-common

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH=$PATH:/Applications/acquia-drupal/drush
