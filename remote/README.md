## 远程控制

## vnc

arch linux 上打开 vnc server，参考：https://wiki.archlinux.org/title/TigerVNC#Accessing_vncserver_via_SSH_tunnels

不开桌面，直接用 headless vnc 的方式，设置了笔记本盖子关闭是自动关闭屏幕。


```bash
$ vncpasswd

$ vim /etc/tigervnc/vncserver.users
:1=lzx

$ yay -S xfce

$ cat ~/.vnc/config
session=xfce
geometry=1920x1080
alwaysshared

$ sudo systemctl enable --now vncserver@:1.service

# 添加了 toggle-lid-dpms 脚本
$ make acpi-handler
$ make toggle-service
```
