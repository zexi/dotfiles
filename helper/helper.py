#!/usr/bin/env python

import os
import logging
import subprocess
import argparse
import shutil


from .type import VIM_PLUG, TMUX_PLUG, FLAKE8_PLUG
from .type import SRC, DEST, CLS
from .type import HOME, PROJECT_DIR


class PluginConfig(object):
    @classmethod
    def config_map(cls):
        from . import setting
        return setting.CONFIG_MAP

    @classmethod
    def get_config(cls, plugin_name):
        conf = cls.config_map().get(plugin_name, None)
        if not conf:
            raise Exception("Plugin %s config not found." % plugin_name)
        return conf

    @classmethod
    def get_src_file(cls, plugin_name):
        conf = cls.get_config(plugin_name)
        return conf[SRC]

    @classmethod
    def get_dest_file(cls, plugin_name):
        conf = cls.get_config(plugin_name)
        return conf[DEST]

    @classmethod
    def get_config_class(cls, plugin_name):
        return cls.get_config(plugin_name)[CLS]

    @classmethod
    def get_all_plugins_objects(cls):
        config_objects = []
        for p in cls.config_map().keys():
            conf_cls = cls.get_config_class(p)
            if conf_cls:
                config_objects.append(conf_cls())
        return config_objects


def init_argparser():
    parser = argparse.ArgumentParser(prog="dothelper")

    subparsers = parser.add_subparsers(help="commands")

    # Install
    install_parser = subparsers.add_parser('install', help='Install plugins')
    install_parser.add_argument("plugin", nargs='+', help='Plugins need be installed')
    install_parser.set_defaults(func=install_plugins)

    # Uninstall
    install_parser = subparsers.add_parser('uninstall', help='Uninstall plugins')
    install_parser.add_argument("plugin", nargs='+', help='Plugins need be uninstalled')
    install_parser.set_defaults(func=uninstall_plugins)

    args = parser.parse_args()
    return args


def symlink_file(src, dest):
    dest_dir = os.path.dirname(dest)
    if not os.path.exists(dest_dir):
        os.makedirs(dest_dir)

    if os.path.exists(dest) or os.path.islink(dest):
        logging.info('Remove: %s' % dest)
        os.remove(dest)
    logging.info('Create symlink: %s --> %s' % (src, dest))
    os.symlink(src, dest)


def change_project_dir():
    os.chdir(PROJECT_DIR)


def process_call(cmd):
    logging.info("subprocess call cmd: %s" % cmd)
    output = subprocess.check_output(cmd, shell=True)
    return output


def ensure_remove_dir(dir_path):
    if not os.path.exists(dir_path):
        return
    shutil.rmtree(dir_path)
    logging.info("force rm -rf %s" % dir_path)


class BasePluginConfig(object):

    _install_stages_ = ['pre_install', 'install', 'post_install']
    _uninstall_stages_ = ['pre_uninstall', 'uninstall', 'post_uninstall']

    def __init__(self, name):
        self.name = name

    @property
    def src_config_file(self):
        return PluginConfig.get_src_file(self.name)

    @property
    def dest_config_file(self):
        return PluginConfig.get_dest_file(self.name)

    def ensure_package_manager_installed(self):
        return

    def pre_install(self):
        self.symlink_config()
        self.ensure_package_manager_installed()
        return

    def symlink_config(self):
        symlink_file(self.src_config_file, self.dest_config_file)

    def unlink_config(self):
        dest = self.dest_config_file
        if os.path.exists(dest) or os.path.islink(dest):
            logging.info('Remove: %s' % dest)
            os.remove(dest)

    def install(self):
        return

    def post_install(self):
        return

    def pre_uninstall(self):
        return

    def uninstall(self):
        self.unlink_config()
        return

    def post_uninstall(self):
        return

    def exec_stage(self, stage_name, stage_func):
        if not callable(stage_func):
            raise Exception("%s stage_func %s not callable!!!" % (stage_name, stage_func))

        try:
            logging.info("Execute stage %s..." % stage_name)
            stage_func()
            logging.info("Execute stage %s completed." % stage_name)
        except Exception as e:
            logging.exception("Execute stage error: %s !" % stage_name)
            raise e

    def exec_stages(self, stages):
        for stage_name in stages:
            stage_func = getattr(self, stage_name)
            self.exec_stage(stage_name, stage_func)

    def exec_install(self):
        return self.exec_stages(self._install_stages_)

    def exec_uninstall(self):
        return self.exec_stages(self._uninstall_stages_)


class TmuxConfig(BasePluginConfig):

    _tmux_config_dir = os.path.join(HOME, '.tmux')

    def __init__(self):
        super(TmuxConfig, self).__init__(TMUX_PLUG)

    def ensure_tpm_install(self):
        if os.path.exists(os.path.join(HOME, '.tmux/plugins/tpm')):
            return
        cmd = "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
                ~/.tmux/plugins/tpm/bin/install_plugins"
        process_call(cmd)

    def ensure_package_manager_installed(self):
        self.ensure_tpm_install()

    def uninstall(self):
        super(TmuxConfig, self).uninstall()
        ensure_remove_dir(self._tmux_config_dir)


class VimConfig(BasePluginConfig):

    def __init__(self):
        super(VimConfig, self).__init__(VIM_PLUG)

    def ensure_vimplug_install(self):
        if os.path.exists(os.path.join(HOME, '.vim/autoload/plug.vim')):
            return
        cmd = 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        process_call(cmd)

    def ensure_package_manager_installed(self):
        self.ensure_vimplug_install()


class Flake8Config(BasePluginConfig):

    def __init__(self):
        super(Flake8Config, self).__init__(FLAKE8_PLUG)

    def ensure_flake8_installed(self):
        cmd = 'pip install flake8'
        process_call(cmd)

    def ensure_package_manager_installed(self):
        self.ensure_flake8_installed()


def get_all_plugins_objects():
    return PluginConfig.get_all_plugins_objects()


def get_plugins_objects(plugins):
    res_objs = []
    objs = get_all_plugins_objects()
    for p in plugins:
        for obj in objs:
            if p == obj.name:
                res_objs.append(obj)
    return res_objs


def get_plugins_by_args(args):
    plugins = []
    if 'all' in args.plugin:
        plugins = get_all_plugins_objects()
    else:
        plugins = get_plugins_objects(args.plugin)
    return plugins


def install_plugins(args):
    for p in get_plugins_by_args(args):
        p.exec_install()


def uninstall_plugins(args):
    for p in get_plugins_by_args(args):
        p.exec_uninstall()


def setup_logger():
    logger = logging.getLogger()
    handler = logging.StreamHandler()
    formatter = logging.Formatter('[%(asctime)s %(name)s %(levelname)s] %(message)s')
    handler.setFormatter(formatter)
    logger.addHandler(handler)
    logger.setLevel(logging.DEBUG)
    return logger


def main():
    change_project_dir()
    setup_logger()
    args = init_argparser()
    if args.func:
        args.func(args)


if __name__ == '__main__':
    main()
