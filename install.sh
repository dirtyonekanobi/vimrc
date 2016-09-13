#!/bin/sh

VIMDIR=~/.vim

warn() {
    echo "$1" >&2	
}

die() {
    warn "$1"
    exit 1
}


[ -e "$VIMDIR/vimrc" ] && die "$VIMDIR/vimrc already exists."
[ -e "~/.vimrc" ] && die ".vimrc already exists."

mkdir -p $VIMDIR 
cp . $VIMDIR && cd $VIMDIR
vim +PluginInstall
if [ -e $VIMDIR/bundle/YouCompleteMe ]; then
	$VIMDIR/bundle/YouCompleteMe/install.py
fi



echo "All Set, All Installed, All GOOOOD"

