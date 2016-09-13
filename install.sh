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
cp -r . $VIMDIR && cd $VIMDIR
apt-get install -y git vim vim-nox
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

if [ -e "$VIMDIR/bundle/YouCompleteMe"]; then
	$VIMDIR/bundle/YouCompleteMe/install.py --clang-completer
fi

echo "All Set, All Installed, All GOOOOD"
