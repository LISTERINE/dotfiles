from subprocess import checkoutput
from os import path, mkdirs, chdir
from errno import EEXIST


def mkdir_p(pth):
    try:
        makedirs(pth)
    except OSError as exc:  # Python >2.5
        if exc.errno == EEXIST and path.isdir(pth):
            pass
        else:
            raise

def bash(command):
    return checkoutput(['/bin/bash', '-c', command])

bash("packages.sh")
bash("post.sh")


########## Variables

dir = path.expanduser("~/.dotfiles")        # dotfiles directory
olddir = path.expanduser("~/.dotfiles_old") # old dotfiles backup directory
files = ["bashrc", "vim", "vimrc", "bash_aliases", "bash_prompt", "tmux.conf", "docker-tools.sh", "venv-tools"] # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
mkdir_p(olddir)
# change to the dotfiles directory
chdir(dir)
# download and load docker-tools
bash("git clone https://github.com/LISTERINE/docker-tools.git")
bash("mv docker-tools/.docker-tools.sh .")
bash("ln -s {1}/vim/vimrc {2}/vimrc".format(dir, dir))

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in files:
    bash("mv ~/.{0} {1} 2>/dev/null".format(file, olddir))
    bash("ln -s {0}/{1} ~/.{3}".format(dir, file, file))

# install neobundle once the propper dotfiles are in place
bash("git clone https://github.com/Shougo/neobundle.vim.git")

bash("neobundle.vim/bin/install.sh")
bash("neobundle.vim/bin/neoinstall")
bash("rm -rf docker-tools")
bash("rm -rf neobundle.vim")

print "run 'source ~/.bashrc'"