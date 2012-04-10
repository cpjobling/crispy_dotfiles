export ENVSETUP="${HOME}/.envsetup"
[[ -f ${ENVSETUP}/bashrc-common && -n "${PS1}" ]] && . ${ENVSETUP}/bashrc-common
