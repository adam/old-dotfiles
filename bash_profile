source ~/.bash/paths
source ~/.bash/aliases
source ~/.bash/functions
source ~/.bash/config

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -f ~/.localrc ]; then
	. ~/.localrc
fi

##
# Your previous /Users/chris/.bash_profile file was backed up as /Users/chris/.bash_profile.macports-saved_2009-09-12_at_11:23:49
##

# MacPorts Installer addition on 2009-09-12_at_11:23:49: adding an appropriate PATH variable for use with MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

