if [ -f ~/.bashrc ];
then
    source ~/.bashrc
fi
if [ -f ~/.profile ];
then
    source ~/.profile ];
fi
export PATH=~/bin:${PATH}:/usr/local/mysql/bin

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export LC_CTYPE=en_US.UTF-8

export EDITOR="vim"
export CVSEDITOR="vim"
export SVN_EDITOR="vim"

export GOROOT=$HOME/go
export GOARCH=amd64
export GOOS=darwin



##
# Your previous /Users/eechris/.bash_profile file was backed up as /Users/eechris/.bash_profile.macports-saved_2011-03-25_at_23:16:18
##

# MacPorts Installer addition on 2011-03-25_at_23:16:18: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


