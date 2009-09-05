source ~/.bash/aliases
source ~/.bash/functions
source ~/.bash/config

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -f ~/.localrc ]; then
	. ~/.localrc
fi