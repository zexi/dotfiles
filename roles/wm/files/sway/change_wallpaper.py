#!/usr/bin/env python3

import json
import glob
import random
import sys
import subprocess


def show_usage():
    usage = """
    %s <wallpapaers-dir>
    """ % __file__
    print(usage)


def get_sway_outputs():
    pass


def choice_pic(wallpapaer_dir):
    walls = []
    for pic in glob.glob(wallpapaer_dir + "/*.*"):
        if pic.endswith('.jpg') or pic.endswith('.png'):
            walls.append(pic)
    return random.choice(walls)


def set_outputs(outputs, walls_dir):
    for output in outputs:
        set_output(output, walls_dir)


def sway_msg(*args, nojoin=False):
    cmd = ['swaymsg']
    if nojoin:
        cmd.extend(args)
    else:
        cmd.append(' '.join(args))
    return subprocess.check_output(cmd)


def sway_output(*args):
    output = ['output']
    output.extend(args)
    return sway_msg(*output)


def get_displays():
    displays = json.loads(sway_msg("-t", "get_outputs", "-r", nojoin=True))
    return displays


def set_output(output, walls_dir):
    pic = choice_pic(walls_dir)
    sway_output(output, "background", pic, "fill")


def main():
    walls_dir = sys.argv[1]
    displays = get_displays()
    outputs = [display.get('name', None) for display in displays if display.get('name', None)]
    set_outputs(outputs, walls_dir)


if __name__ == '__main__':
    main()
