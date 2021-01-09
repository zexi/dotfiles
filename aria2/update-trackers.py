#!/usr/bin/env python

import os
import urllib.request


# DEFAULT_URL = 'https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/best_aria2.txt'
DEFAULT_URL = 'https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best_ip.txt'


def get_trackers(url=DEFAULT_URL):
    content = urllib.request.urlopen(url).read()
    return b''.join(content.split()).decode('utf-8')


def inject_to_config(config_path, trackers):

    def inject(contents, trackers):
        new_lines = []
        for line in contents:
            if line.startswith('bt-tracker='):
                line = 'bt-tracker=%s' % trackers
            new_lines.append(line)
        return ''.join(new_lines)

    with open(config_path, 'r+', encoding="utf-8") as f:
        old_content = f.readlines()
        new_content = inject(old_content, trackers)
        # set the pointer to the beginning of the file in order to rewrite
        f.seek(0)
        # delete actual file content
        f.truncate()
        # rewrite updated file content
        f.write(new_content)


if __name__ == '__main__':
    cur_dir = os.path.dirname(os.path.realpath(__file__))
    inject_to_config(os.path.join(cur_dir, './aria2.conf'), get_trackers())
