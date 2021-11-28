# dotfiles of mine

## Pre install

### add archlinuxcn mirror

1. add archlinuxcn mirror

Ref: https://mirror.tuna.tsinghua.edu.cn/help/archlinuxcn/

```sh
vim /etc/pacman.conf # add below contents
[archlinuxcn]
#SigLevel = Optional TrustedOnly
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

2. install 

```bash
pacman -Syy
pacman -S archlinuxcn-keyring yay
```

### config zsh

```bash
pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Setup Desktop environment

- [sway](https://wiki.archlinux.org/index.php/Sway) for common use
- [gnome](https://wiki.archlinux.org/index.php/GNOME) for backup use

### Environment variables config

Set desktop default environment

```bash
cat /etc/environment
#
# This file is parsed by pam_env module
#
# Syntax: simple "KEY=VAL" pairs on separate lines
#
export INPUT_METHOD=fcitx
export GTK_IM_MODULE=fcitx
export QT4_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export LANG=en_US.UTF-8
export _JAVA_AWT_WM_NONREPARENTING=1
# manually set the screen factor
# it is important to set QT_AUTO_SCREEN_SCALE_FACTOR=0 otherwise
# some applications which explicitly force high DPI enabling get scaled twice
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.2
export WINIT_UNIX_BACKEND=x11
```

### Gnome

```bash
pacman -S gnome-extra gdm
systemctl enable gdm --now

# tweak-tool config
# 'Keyboard & Mouse' -> 'Additional Layout Options':
# Caps Lock behavior: Caps Lock is also a Ctrl
# Alt and Win behavior:
# Alt is swapped with Win
```

### Sway

```bash
# install sway wm
pacman -S sway waybar swaylock swayidle mako

# install i3 wm
pacman -S i3 compton i3status-rust mons screenkey xsel dunst

# dunst and mako can't be installed at the same time

# install depends tools
pacman -S brightnessctl rofi-lbonn-wayland-git grim slurp wallutils \
  termite termite-terminfo alacritty powerline-fonts ttf-font-awesome \
  ttf-monaco wqy-microhei wqy-zenhei wqy-bitmapfont noto-fonts-emoji  ttf-jetbrains-mono\
  pamixer pnmixer pavucontrol alsa-utils \
  bluez bluez-utils blueman pulseaudio-bluetooth \
  network-manager-applet \
  acpilight \
  ydcv

yay -S wl-clipboard redshift gammastep wdisplays-git \
  network-manager-applet libappindicator-gtk3 wofi-hg
```

### git

```sh
# tells Git to keep your password cached in memory for a particular amount of minutes.
git config --global credential.helper "cache --timeout=86400"
```

### install font

https://wiki.archlinux.org/index.php/Fonts_(简体中文)#中文字

### input method

install fcitx

```bash
# fcitx 5
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-lua fcitx5-rime rime-emoji
```

### neovim

```sh
yay -S neovim-nightly

./dothelper install vim
ln -s ~/.vimrc ~/.vim/init.vim
ln -s ~/.vim ~/.config/nvim
ln -s $(pwd)/coc-settings.json ~/.vim/coc-settings.json
```

#### complete & goto definitions

```sh
# golang
pacman -S go
go get -v golang.org/x/tools/gopls
```

### tmux

```bash
pacman -S tmux
./dothelper install tmux
```

### browser

```bash
pacman -S google-chrome chromium firefox

cat <<EOF > ~/.config/chromium-flags.conf
--password-store=gnome
EOF
cat <<EOF > ~/.config/chrome-flags.conf
--password-store=gnome
EOF
```

### nvidia & intel gpu

* set x11 nvidia releated xorg config

### ssh config

```bash
cat <<EOF > ~/.ssh/config
ControlPersist yes
TCPKeepAlive yes


# Merge this file into ~/.ssh/config or run `man ssh_config` for more info
 Host *
   SendEnv LANG LC_*
   Compression yes
   ControlMaster auto
   ControlPath /tmp/.tmp_%r@%h:%p
   ControlPersist yes
   TCPKeepAlive yes
   ServerAliveInterval=15
   ServerAliveCountMax=6
   IdentityFile ~/.ssh/id_rsa
   ForwardAgent yes
   ForwardX11 yes
   ForwardX11Trusted yes
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
```

### others

* netease-cloud-music, ieaseMusic
* guake: drop down terminal
    - bind 'Super+G': dbus-send --type=method_call --dest=org.guake3.RemoteControl /org/guake3/RemoteControl org.guake3.RemoteControl.show_from_remote

### Gnome extensions

| Name                                 | Description                                                                                |
|--------------------------------------|--------------------------------------------------------------------------------------------|
| Activities Configuratior             |                                                                                            |
| * espresso                           | Caffeine extension https://extensions.gnome.org/extension/4135/espresso/                   |
| Dash to Dock                         |                                                                                            |
| * system-monitor                     | system metrics monitor                                                                     |
| * clipboard Indicator                |                                                                                            |
| * AppIndicator and KStatusNotifierItem | show native x11 top icon: https://extensions.gnome.org/extension/615/appindicator-support/ |
| * ddterm                               | drop down terminal: https://extensions.gnome.org/extension/3780/ddterm/                    |
| switcher                             | https://github.com/daniellandau/switcher                                                   |
| pop-os-shell(for tile windows)       | yay -S gnome-shell-extension-pop-shell-git                                                 |


```bash
# gnome set keyboard sensitivity
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
```

### bluetooth

- audio
    - [Bluetooth_headset#Setting_up_auto_connection](https://wiki.archlinux.org/index.php/Bluetooth_headset#Setting_up_auto_connection)


    ```bash
    # list bluetooth devices
    $ bluetoothctl devices
    Device 04:5D:4B:17:9B:E1 MDR-1000X

    # trust it
    $ bluetoothctl trust 4:5D:4B:17:9B:E1
    ```

    - [Switch on connect](https://wiki.archlinux.org/index.php/PulseAudio#Switch_on_connect)

- keyboard
    - [Bluetooth keyboard](https://wiki.archlinux.org/index.php/Bluetooth_keyboard)

