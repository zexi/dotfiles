#!/usr/bin/env python

from os import listdir
from shutil import copyfile
import sys

# install package: yay -S plasma-workspace-wallpapers
# wallpapers path: /usr/share/wallpapers


def get_img_paths(dir_path, dst_dir, name):
    real_dir = "%s/%s/contents/images" % (dir_path, name)
    imgs = listdir(real_dir)
    imgs = [(x[:x.index('.')], x[x.index('.'):]) for x in imgs]
    def sort_pixel(val):
        desc = val[0].split('x')
        width = int(desc[0])
        height = int(desc[1])
        return width * height
    imgs.sort(key=sort_pixel, reverse=True)
    #import ipdb; ipdb.set_trace()
    best_img = imgs[0]

    real_path = "%s/%s%s" % (real_dir, best_img[0], best_img[1])
    to_path = "%s/%s%s" % (dst_dir, name, best_img[1])
    return (real_path, to_path)


def copy_imgs(src_dir, dst_dir):
    names = listdir(src_dir)
    for n in names:
        if n == 'deepin':
            continue
        pairs = get_img_paths(src_dir, dst_dir, n)
        copyfile(pairs[0], pairs[1])

if __name__ == '__main__':
    print(sys.argv)
    if len(sys.argv) != 3:
        print("useage: %s <kde_wallpaper_dir> <dst_dir>" % __file__)
        exit(1)
    src_dir = sys.argv[1]
    dst_dir = sys.argv[2]
    copy_imgs(src_dir, dst_dir)
