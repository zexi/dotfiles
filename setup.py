#!/usr/bin/env python2.7

import os

src_des_path = {'vimrc': '.vimrc', 'tmux.conf': '.tmux.conf', 'flake8': '.conf/flake8'}

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

move_file(src_des_path)
