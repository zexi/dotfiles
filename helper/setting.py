import os

from .type import VIM_PLUG, TMUX_PLUG, FLAKE8_PLUG
from .type import SRC, DEST, CLS
from .type import HOME, PROJECT_DIR

from .helper import TmuxConfig
from .helper import VimConfig
from .helper import Flake8Config


CONFIG_MAP = {
	VIM_PLUG: {
		SRC: os.path.join(PROJECT_DIR, 'vimrc'),
		DEST: os.path.join(HOME, '.vimrc'),
		CLS: VimConfig,
	},

	TMUX_PLUG: {
		SRC: os.path.join(PROJECT_DIR, 'tmux.conf'),
		DEST: os.path.join(HOME, '.tmux.conf'),
		CLS: TmuxConfig,
	},

	FLAKE8_PLUG: {
		SRC: os.path.join(PROJECT_DIR, 'flake8'),
		DEST: os.path.join(HOME, '.conf/flake8'),
		CLS: Flake8Config,
	},

}
