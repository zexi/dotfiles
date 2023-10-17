#!/usr/bin/env python3

from __future__ import annotations


import subprocess
import json
import sys
from typing import Optional


class Frame:

    def __init__(self, x, y, w, h):
        self.x = x
        self.y = y
        self.w = w
        self.h = h


class Window:

    def __init__(self, data: dict):
        self.data = data

    def get_id(self) -> Optional[str]:
        return self.data.get('id')

    def get_app(self) -> Optional[str]:
        return self.data.get('app')

    def get_display(self) -> Optional[int]:
        return self.data.get('display')

    def get_frame(self) -> Frame:
        frame = self.data.get('frame', {})
        return Frame(frame['x'], frame['y'],
                     frame['w'], frame['h'])

    def get_frame_x(self):
        return self.get_frame().x

    def get_frame_y(self):
        return self.get_frame().y

    def has_focus(self) -> bool:
        return self.data.get('has-focus', False)

    def focus_west(self, windows: Windows) -> None:
        self.focus_direct(windows, 'west')

    def focus_east(self, windows: Windows) -> None:
        self.focus_direct(windows, 'east')

    def focus_direct(self, windows: Windows, direct: str) -> None:
        wins = []
        for w in windows:
            if w.get_frame_y() == self.get_frame_y():
                if direct == 'west':
                    if w.get_frame_x() < self.get_frame_x():
                        wins.append(w)
                elif direct == 'east':
                    if w.get_frame_x() > self.get_frame_x():
                        wins.append(w)
                else:
                    raise Exception(f'Invalid direction {direct}')
        if len(wins) == 0:
            print(f"Not found {direct} windows")
            return
        wins[0].do_focus()


    def do_focus(self):
        run_yabai_cmd(f'-m window {self.get_id()} --focus')

    def __repr__(self) -> str:
        return f'{self.data}'


class Windows:

    def __init__(self, windows_data: list[dict]):
        self.windows: list[Window] = []
        for data in windows_data:
            self.windows.append(Window(data))

    def get_focused_window(self) -> Optional[Window]:
        for w in self.windows:
            if w.has_focus():
                return w
        return None

    def __len__(self):
        return len(self.windows)

    def __getitem__(self, pos):
        return self.windows[pos]

    def __repr__(self) -> str:
        return f'{self.windows}'


def run_yabai_cmd(subcmd: str):
    cmd = ["yabai"]
    cmd = cmd + subcmd.split(' ') 
    return subprocess.check_output(cmd)


def get_windows():
    output = run_yabai_cmd("-m query --windows")
    return Windows(json.loads(output))


WIN_WEST = 'west'
WIN_EAST = 'east'
DIS_CYCLE = 'display_cycle'


def display_focus_cycle(all_wins: Windows, cur_window: Window):
    cur_display = cur_window.get_display()
    if not cur_display:
        raise Exception(f'Not found display from current window: {cur_display}')
    display_nums = (win.get_display() for win in all_wins)
    max_display_num = max(display_nums)

    focus_num =  cur_display + 1
    if focus_num > max_display_num:
        focus_num = focus_num % max_display_num
    run_yabai_cmd(f"-m display --focus {focus_num}")


def start():
    if len(sys.argv) != 2:
        raise RuntimeWarning(f'Usage {sys.argv[0]} {WIN_WEST}|{WIN_EAST}|{DIS_CYCLE}')
    direction = sys.argv[1]

    windows = get_windows()
    cur_window = windows.get_focused_window()
    if not cur_window:
        raise Exception('Not found current focused window')
    if direction == DIS_CYCLE:
        display_focus_cycle(windows, cur_window)
    else:
        cur_window.focus_direct(windows, direction)

if __name__ == '__main__':
    try:
        start()
    except RuntimeWarning as e:
        print(e)
        sys.exit(1)
