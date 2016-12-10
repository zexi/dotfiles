#!/usr/bin/env python2.7

import os

src_des_path = {'vimrc': '.vimrc', 'tmux.conf': '.tmux.conf', 'flake8': '.conf/flake8', 'pryrc': '.pryrc'}

mypath = os.path.abspath(os.path.dirname(os.path.realpath(__file__))) + os.sep
os.chdir(mypath)

def move_file(src2des):
    home_path = os.getenv('HOME') + os.sep

    if not os.path.exists(home_path + '.conf'):
        os.makedirs(home_path + '.conf')

    for src, des in src2des.items():
        des = home_path + des
        if os.path.exists(des):
            print 'Remove: %s' % des
            os.remove(des)
        src_abs_path = os.path.join(mypath, src)
        print 'Create symlink: %s --> %s' % (des, src_abs_path)
        os.symlink(src_abs_path, des)

def setup_tools():
    tools_path = ['~/.vim/autoload/plug.vim', '~/.oh-my-zsh']
    tools_path = [os.path.expanduser(p) for p in tools_path]
    for p in tools_path:
        if not os.path.exists(p):
            if 'vim' in p:
                cmd = 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
            if 'zsh' in p:
                cmd = 'sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"'
            os.system(cmd)

move_file(src_des_path)
#setup_tools()
