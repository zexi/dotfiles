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

### Gnome

```bash
pacman -S gnome-extra gdm
systemctl enable gdm --now
```

Set gdm default environment

```bash
cat /etc/environment
#
# This file is parsed by pam_env module
#
# Syntax: simple "KEY=VAL" pairs on separate lines
#
export GTK_IM_MODULE=fcitx
export QT4_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export LANG=en_US.UTF-8
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.1
export WINIT_UNIX_BACKEND=x11
```

### Sway

```bash
# install sway wm
pacman -S sway waybar swaylock swayidle mako

# install depends tools
pacman -S brightnessctl rofi grim slurp wallutils \
  termite termite-terminfo powerline-fonts ttf-font-awesome \
  pamixer pnmixer pavucontrol alsa-utils \
  bluez bluez-utils blueman pulseaudio-bluetooth \
  network-manager-applet \
  acpilight \
  ydcv

yay -S wl-clipboard wl-clipboard-x11 redshift-wlr-gamma-control-git wdisplays-git \
  network-manager-applet-indicator libappindicator-gtk3 wofi-hg
```

### install font

https://wiki.archlinux.org/index.php/Fonts_(简体中文)#中文字

### input method

install fcitx fcitx-configtool

```bash
pacman -S fcitx fcitx-configtool fcitx-sogoupinyin fcitx-im
```

### neovim

```sh
yay -S neovim-nightly

./dothelper install vim
ln -s ~/.vimrc ~/.vim/init.vim
ln -s ~/.vim ~/.config/nvim
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

### Gnome extensions

| Name                     | Description        |
|--------------------------|--------------------|
| Activities Configuratior |                    |
| Caffeine                 |                    |
| Dash to Dock             |                    |
| Switcher                 |                    |
| system-monitor           |
