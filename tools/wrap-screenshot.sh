#!/bin/bash

tmp_pic="$(xdg-user-dir PICTURES)/$(date +'%Y-%m-%d-%H%M%S_grim.png')"

grim -g "$(slurp)" "$tmp_pic"

ksnip "$tmp_pic"
