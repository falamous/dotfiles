# my dotfiles and an ansible playbook to deploy them

## USAGE:
after reboot to installed system(from non-root user):
```bash
mkdir -p ~/share/src && cd ~/share/src
git clone https://github.com/falamous/dotfiles
cd dotfiles
ansible-galaxy install -r requirements.yml
ansible-playbook -K main.yml
```
## functionality:
- links most ~ files to relevant files in ~/share to centralize user data to one data for backups and file transfer
- installs yay
- changes pacman.conf to use 16 threads for downloading packages
- links ~/.config, ~/.xinitrc, ~/.Xresources to relevant parts of the repo (for easy config modifications)
- installs picom, dunst, rofi, flameshot, cronie, pipewire and other essentials
- installs ly for the display manager, and qtile for the window manager
- installs zsh and sets it as your default shell
- installs neovim, nvim-plug and downloads plugged extensions
- installs mlocate and puts updatedb in cron
- adds hwdb entries to remap capslock to escape and various keys on my laptop keyboard
- configures various programs to conform to xdg base directory
- installs pass and sets as the git credential helper
- installs gdb, gef and adds gef to gdbrc
- installs my simple mac randomization script and puts in cron
- installs and compiles my build of tabbed
- installs, compiles and set my build of slock as the screen locker
- installs lots of libraries, tools, languages, ... that I use. sometimes
- can copy and chown files from specified directory into ~
- on ROG laptops:
    - installs and enables asusctl. sets the battery charge limit to 85%
    - installs supergfxctl and switches the gpu mode in integrated

## a word of warning:
this installs A LOT OF stuff. the final disk footprint is more than 20G, so if you want to use this, pick and choose what you actually care to install.

## shameless plagiarism from:
- https://github.com/n0nvme/ansible-arch
