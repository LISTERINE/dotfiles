#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# It will also determine current platform and allow package isntallation with pre and post install actions
############################

source platformer.sh

# check this var later/in other scripts to see if anything needed to get installed
required_install=false;

# Pre-package-install actions
if [ -a pre-install.sh ]
    then
	echo "Running pre-install..."
    source pre-install.sh
	echo "Pre-install complete"
fi
# Install any required packages for the environment
if [ -a package_install.sh ]
    then
	echo "Running package install..."
    source package_install.sh
    required_install=true;
	echo "Package install complete"
fi
# Once packages installed,
if [ -a post-install.sh ]
    then
	echo "Running post-install..."
    source post-install.sh
	echo "Post-install complete"
fi


########## Variables

dir=~/.dotfiles        # dotfiles directory
olddir=~/.dotfiles_old # old dotfiles backup directory
files="$extra_files bashrc vim vimrc bash_aliases bash_prompt tmux.conf venv-tools" # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"
echo

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"
echo

echo Symlinking vimrc
ln -s $dir/.vim/vimrc $dir/.vimrc
echo "...done"
echo

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
    mv ~/.$file $olddir 2>/dev/null
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done
echo "...done"
echo

# install neobundle once the propper dotfiles are in place
echo Getting neobundle
git clone https://github.com/Shougo/neobundle.vim.git
echo "...done"
echo

echo Installing neobundle
sh neobundle.vim/bin/install.sh
echo "...done"
echo

echo Running vim plugin setup
sh neobundle.vim/bin/neoinstall
echo "...done"
echo

# cleanup
echo Housekeeping
rm -rf neobundle.vim
echo "...done"
echo

source ~/.bashrc

cd ~