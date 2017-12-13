import os

from os.path import dirname, realpath, abspath

VIM_PLUG = 'vim'
TMUX_PLUG = 'tmux'
FLAKE8_PLUG = 'flake8'
PRY_PLUG = 'pry'

SRC = 'src'
DEST = 'dest'
CLS = 'class'

HOME = os.environ['HOME']

PROJECT_DIR = abspath(dirname(dirname(realpath(__file__)))) + os.sep
