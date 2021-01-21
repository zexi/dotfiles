#!/bin/bash -e

function gset() {
    local path="$1"
    local name="$2"
    local value="$3"

    gsettings set "$path" "$name" "$value"
}

# theme
gset org.gnome.desktop.interface gtk-theme Adwaita-dark

# keymap
gset org.gnome.desktop.input-sources xkb-options "['altwin:swap_lalt_lwin','caps:ctrl_modifier']"

# gnome set keyboard sensitivity
gset org.gnome.desktop.peripherals.keyboard repeat-interval 30
gset org.gnome.desktop.peripherals.keyboard delay 250

# set text-scaling-factor to 1.25
#gset org.gnome.desktop.interface text-scaling-factor 1.25

# custom shortcuts setting
# clear some conflict keys
gset org.gnome.desktop.wm.keybindings switch-input-source-backward '[]'
gset org.gnome.desktop.wm.keybindings switch-input-source '[]'

gset org.gnome.shell.keybindings focus-active-notification "['<Super>n']"
gset org.gnome.shell.keybindings toggle-message-tray "['<Super><Shift>n']"

gset org.gnome.desktop.wm.keybindings close "['<Super>q']"
gset org.gnome.desktop.wm.keybindings minimize "['<Super>m']"
gset org.gnome.desktop.wm.keybindings begin-resize "['<Super>r']"
gset org.gnome.desktop.wm.keybindings toggle-maximized "['<Super><Shift>space','<Super><Control>m']"
gset org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"
gset org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>d']"
gset org.gnome.desktop.wm.keybindings cycle-windows "['<Super>semicolon']"

gset org.gnome.mutter.keybindings  toggle-tiled-left "['<Super><Control>h']"
gset org.gnome.mutter.keybindings  toggle-tiled-right "['<Super><Control>l']"

#gset org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "['<Super><Control>a']"

function set_custom_keybinding_prop() {
    local idx="$1"
    local prop="$2"
    local val="$3"
    gsettings set \
        org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$idx/ \
        "$prop" "$val"
}

function add_custom_keybinding() {
    local idx="$1"
    local name="$2"
    local command="$3"
    local binding="$4"

    local cmds=""
    for i in $(seq 0 $idx); do
        if [ -z "$cmds" ]; then
            cmds="'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/'"
        else
            cmds="${cmds}, '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/'"
        fi
    done
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
        "[$cmds]"
    set_custom_keybinding_prop $idx "name" "$name"
    set_custom_keybinding_prop $idx "command" "$command"
    set_custom_keybinding_prop $idx "binding" "$binding"
}

add_custom_keybinding 0 "termite" "/usr/bin/termite" "<Super>Return"
add_custom_keybinding 1 "xfce4-terminal" "/usr/bin/xfce4-terminal" "<Super><Shift>Return"
add_custom_keybinding 2 "ksnip" "/home/lzx/code/dotfiles/tools/ksnip.sh" "<Super><Control>a"
