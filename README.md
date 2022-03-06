# My dotfiles and an ansible playbook to deploy them

## USAGE:
after reboot to installed system(from non-root user):
```bash
cd ~ && mkdir -p src && cd src
git clone https://github.com/falamous/dotfiles
cd dotfiles
ansible-galaxy install -r requirements.yml
ansible-playbook site.yml -K
```

## Functionality:
- installs yay
- changes pacman.conf to use 16 threads for downloading packages
- links ~/.config, ~/.xinitrc, ~/.Xresources to relevant parts of the repo (for easy config modifications)
- links ~/.mozilla to ~/share/mozilla
- installs picom, dunst, rofi, flameshot, cronie, pipewire and other essentials
- installs ly for the display manager, and qtile for the window manager
- installs zsh and sets it as your default shell
- installs neovim, nvim-plug and downloads plugged extensions
- installs mlocate and puts updatedb in cron
- adds hwdb entries to remap capslock to escape and various keys on my laptop keyboard
- installs and enables asusctl. sets the battery charge limit to 85%
- installs gdb, gef and adds gef to gdbrc
- installs my simple mac randomization script and puts in cron
- installs and compiles my build of tabbed
- installs lots of libraries, tools, languages, ... that I use. sometimes
- can copy and chown files from specified directory

## A word of warning
This installs A LOT OF stuff. The final disk footprint is around 20G, so if you want to use this, pick and choose what you actually care to install.
