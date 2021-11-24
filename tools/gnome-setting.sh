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

# power & screen
gset org.gnome.desktop.session idle-delay 1800
gset org.gnome.desktop.screensaver lock-delay 0 # set 0 to lock immediately after blank screen

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
gset org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab', '<Super>Tab']"
gset org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Super><Shift>h']"
gset org.gnome.desktop.wm.keybindings move-to-monitor-down "['<Super><Shift>j']"
gset org.gnome.desktop.wm.keybindings move-to-monitor-up "['<Super><Shift>k']"
gset org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Super><Shift>l']"

gset org.gnome.mutter.keybindings  toggle-tiled-left "['<Super><Control>h']"
gset org.gnome.mutter.keybindings  toggle-tiled-right "['<Super><Control>l']"
gset org.gnome.mutter edge-tiling "true"

#gset org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "['<Super><Control>a']"
gset org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super><Control>BackSpace']"

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
# add_custom_keybinding 3 "guake-toggle" "/usr/bin/guake-toggle" "<Super>g"
add_custom_keybinding 4 "rofi" "/usr/bin/rofi -show-icons -show drun" "<Super>space"
add_custom_keybinding 5 "rofi" "/usr/bin/rofi -show-icons -show window" "<Alt>Tab"

# extensions config
# use https://github.com/daniellandau/switcher instead of rofi
#dconf write /org/gnome/shell/extensions/switcher/show-switcher "['<Super>w']"
#dconf write /org/gnome/shell/extensions/switcher/show-launcher "['<Super>space']"
#dconf write /org/gnome/shell/extensions/switcher/on-active-display "true"
#dconf write /org/gnome/shell/extensions/switcher/matching "1" # fuzzy match
#dconf write /org/gnome/shell/extensions/switcher/font-size "20"
#dconf write /org/gnome/shell/extensions/switcher/icon-size "20"
#dconf write /org/gnome/shell/disable-extension-version-validation "true"
