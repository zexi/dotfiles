#!/usr/bin/env python3

import subprocess
import json


blacklist = (
    'window-switcher',
)


def get_active_display():
    display = json.loads(subprocess.check_output(['swaymsg', '-t', 'get_outputs', '-r']))
    idx = 0
    for d in display:
        if d.get('focused', False):
            return idx
        idx += 1
    return idx


def handle_container(con):
    """
    Recursively find all windows
    """

    windows = []

    if con['type'] in ('con', 'floating_con'):
        app_id = con['id']
        app_name = ""
        if con.get('app_id', None) is not None:
            app_name = con['app_id']
        elif con.get('window_properties', None) is not None:
            app_name = con['window_properties']['class']

        app_title = con['name']
        if app_name and app_title and app_name not in blacklist:
            windows.append((app_id, app_name, app_title,))

    for child in con['nodes']+con['floating_nodes']:
        windows = windows + handle_container(child)

    return windows


def get_tree():
    tree = json.loads(subprocess.check_output(['swaymsg', '-t', 'get_tree']))
    return tree


def get_windows():
    tree = get_tree()
    windows = []

    # Find all workspaces and the windows in them
    for output in tree['nodes']:
        for workspace in output['nodes']:
            if 'nodes' not in workspace.keys() and 'floating_nodes' not in workspace.keys():
                continue

            if workspace.get('nodes', None):
                for container in workspace['nodes']:
                    windows = windows + handle_container(container)

            if workspace.get('floating_nodes', None):
                for container in workspace['floating_nodes']:
                    windows = windows + handle_container(container)

    return windows


# format the list of windows for dmenu/rofi
def to_rofi_input(windows):
    return '\n'.join([f"<{app_id}> {app_name} --- {app_title}" for app_id, app_name, app_title in windows])


def call_rofi(windows_str):
    display = get_active_display()
    select = subprocess.check_output(
        ['rofi', '-dmenu', '-i', '-m', str(display)],
        input=windows_str, universal_newlines=True)
    return select.split(' ')[0][1:-1]


def call_fzf(windows_str):
    select = subprocess.check_output(
        ['fzf'],
        input=windows_str, universal_newlines=True)
    return select.split(' ')[0][1:-1]


def focus(win_id):
    q = f"[con_id=\"{win_id}\"]"
    subprocess.call(['swaymsg', q, "focus"])


if __name__ == '__main__':
    windows_str = to_rofi_input(get_windows())
    print(windows_str)
    #select_win_id = call_rofi(windows_str)
    select_win_id = call_fzf(windows_str)
    print(select_win_id)
    focus(select_win_id)
