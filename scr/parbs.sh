#!/bin/bash

# Preston's Auto Rice Boostrapping Script (PARBS)
# by Luke Smith <luke@lukesmith.xyz>
# modified by Preston
# License: GNU GPLv3

# You can provide a custom repository with -r or a custom programs csv with -p.
# Otherwise, the script will use my defaults.

### OPTIONS AND VARIABLES ###

while getopts ":a:r:p:h" o; do case "${o}" in
  h) echo -e "Optional arguments for custom use:\\n  -r: Dotfiles repository (local file or url)\\n  -p: Dependencies and programs csv (local file or url)\\n  -a: AUR helper (must have pacman-like syntax)\\n  -h: Show this message" && exit ;;
  r) dotfilesrepo=${OPTARG} && git ls-remote "$dotfilesrepo" || exit ;;
  p) progsfile=${OPTARG} ;;
  a) aurhelper=${OPTARG} ;;
  *) echo "-$OPTARG is not a valid option." && exit ;;
esac done

# DEFAULTS:
[ -z ${dotfilesrepo+x} ] && dotfilesrepo="https://github.com/bob16795/mondofied.git"
[ -z ${progsfile+x} ] && progsfile="https://raw.githubusercontent.com/bob16795/mondofied/master/scr/progs.csv"
[ -z ${aurhelper+x} ] && aurhelper="yay"

### FUNCTIONS ###

initialcheck() { pacman -Syyu --noconfirm --needed dialog || { echo "Are you sure you're running this as the root user? Are you sure you're using an Arch-based distro? ;-) Are you sure you have an internet connection? Are you sure your Arch keyring is updated?"; exit; } ;}

preinstallmsg() { \
  dialog --title "Let's get this party started!" --yes-label "Let's go!" --no-label "No, nevermind!" --yesno "The rest of the installation will now be totally automated, so you can sit back and relax.\\n\\nIt will take some time, but when done, you can relax even more with your complete system.\\n\\nNow just press <Let's go!> and the system will begin installation!" 13 60 || { clear; exit; }
  }

welcomemsg() { \
  dialog --title "Welcome!" --msgbox "Welcome to Preston's Auto-Rice Bootstrapping Script!\\n\\nThis script will automatically install a fully-featured i3wm Arch Linux desktop, which I use as my main machine.\\n\\n-Preston" 10 60
  }

refreshkeys() { \
  dialog --infobox "Refreshing Arch Keyring..." 4 40
  pacman --noconfirm -Sy archlinux-keyring >/dev/null 2>&1
  }

getuserandpass() { \
  # Prompts user for new username an password.
  # Checks if username is valid and confirms passwd.
  name=$(dialog --inputbox "First, please enter a name for the user account." 10 60 3>&1 1>&2 2>&3 3>&1) || exit
  namere="^[a-z_][a-z0-9_-]*$"
  while ! [[ "${name}" =~ ${namere} ]]; do
    name=$(dialog --no-cancel --inputbox "Username not valid. Give a username beginning with a letter, with only lowercase letters, - or _." 10 60 3>&1 1>&2 2>&3 3>&1)
  done
  pass1=$(dialog --no-cancel --passwordbox "Enter a password for that user." 10 60 3>&1 1>&2 2>&3 3>&1)
  pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
  while ! [[ ${pass1} == "${pass2}" ]]; do
    unset pass2
    pass1=$(dialog --no-cancel --passwordbox "Passwords do not match.\\n\\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
    pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
  done ;}

usercheck() { \
  ! (id -u "$name" >/dev/null) 2>&1 ||
  dialog --colors --title "WARNING!" --yes-label "CONTINUE" --no-label "No wait..." --yesno "The user \`$name\` already exists on this system. PARBS can install for a user already existing, but it will \\Zboverwrite\\Zn any conflicting settings/dotfiles on the user account.\\n\\nLARBS will \\Zbnot\\Zn overwrite your user files, documents, videos, etc., so don't worry about that, but only click <CONTINUE> if you don't mind your settings being overwritten.\\n\\nNote also that PARBS will change $name's password to the one you just gave." 14 70
  }

adduserandpass() { \
  # Adds user `$name` with password $pass1.
  dialog --infobox "Adding user \"$name\"..." 4 50
  useradd -m -g wheel -s /bin/bash "$name" >/dev/null 2>&1 ||
  usermod -a -G wheel "$name" && mkdir -p /home/"$name" && chown "$name":wheel /home/"$name"
  echo "$name:$pass1" | chpasswd
  unset pass1 pass2 ;}

gitmakeinstall() {
  dir=$(mktemp -d)
  dialog --title "PARBS Installation" --infobox "Installing \`$(basename "$1")\` ($n of $total) via \`git\` and \`make\`. $(basename "$1") $2" 5 70
  git clone --depth 1 "$1" "$dir" >/dev/null 2>&1
  cd "$dir" || exit
  make >/dev/null 2>&1
  make install >/dev/null 2>&1
  cd /tmp || return ;}

maininstall() { # Installs all needed programs from main repo.
  dialog --title "PARBS Installation" --infobox "Installing \`$1\` ($n of $total). $1 $2" 5 70
  pacman --noconfirm --needed -S "$1" >/dev/null 2>&1
  }

aurinstall() { \
  dialog --title "PARBS Installation" --infobox "Installing \`$1\` ($n of $total) from the AUR. $1 $2" 5 70
  grep "^$1$" <<< "$aurinstalled" && return
  sudo -u "$name" $aurhelper -S --noconfirm "$1" >/dev/null 2>&1
  }

installationloop() { \
  ([ -f "$progsfile" ] && cp "$progsfile" /tmp/progs.csv) || curl -Ls "$progsfile" | sed '/^#/d' > /tmp/progs.csv
  total=$(wc -l < /tmp/progs.csv)
  aurinstalled=$(pacman -Qm | awk '{print $1}')
  while IFS=, read -r tag program comment; do
  n=$((n+1))
  echo "$comment" | grep "^\".*\"$" >/dev/null && comment="$(echo "$comment" | sed "s/\(^\"\|\"$\)//g")"
  case "$tag" in
  "") maininstall "$program" "$comment" ;;
  "A") aurinstall "$program" "$comment" ;;
  "G") gitmakeinstall "$program" "$comment" ;;
  esac
  done < /tmp/progs.csv ;}

serviceinit() { for service in "$@"; do
  dialog --infobox "Enabling \"$service\"..." 4 40
  systemctl enable "$service"
  systemctl start "$service"
  done ;}

newperms() { # Set special sudoers settings for install (or after).
  sed -i "/#PARBS/d" /etc/sudoers
  echo -e "$@ #PARBS" >> /etc/sudoers ;}

systembeepoff() { dialog --infobox "Getting rid of that retarded error beep sound..." 10 50
  rmmod pcspkr
  echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf ;}

putgitrepo() { # Downlods a gitrepo $1 and places the files in $2 only overwriting conflicts
  dialog --infobox "Downloading and installing config files..." 4 60
  dir=$(mktemp -d)
  chown -R "$name":wheel "$dir"
  sudo -u "$name" git clone --depth 1 --recursive "$1" "$dir"/gitrepo >/dev/null 2>&1 &&
  sudo -u "$name" mkdir -p "$2" &&
  sudo -u "$name" cp -rT "$dir"/gitrepo "$2"
  }

resetpulse() { dialog --infobox "Reseting Pulseaudio..." 4 50
  killall pulseaudio
  sudo -n "$name" pulseaudio --start ;}

manualinstall() { # Installs $1 manually if not installed. Used only for AUR helper here.
  [[ -f /usr/bin/$1 ]] || (
  dialog --infobox "Installing \"$1\", an AUR helper..." 4 50
  cd /tmp || exit
  rm -rf /tmp/"$1"*
  curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/"$1".tar.gz &&
  sudo -u "$name" tar -xvf "$1".tar.gz >/dev/null 2>&1 &&
  cd "$1" &&
  sudo -u "$name" makepkg --noconfirm -si >/dev/null 2>&1
  cd /tmp || return) ;}

finalize(){ \
  dialog --infobox "Preparing welcome message..." 4 50
  echo "exec_always --no-startup-id notify-send -i ~/.scripts/pix/PARBS.png '<b>Welcome to PARBS:</b> Press Super+F1 for the manual.' -t 10000"  >> "/home/$name/.config/i3/config"
  dialog --title "All done!" --msgbox "Congrats! Provided there were no hidden errors, the script completed successfully and all the programs and configuration files should be in place.\\n\\nTo run the new graphical environment, log out and log back in as your new user, then run the command \"startx\" to start the graphical environment (it will start automatically in tty1).\\n\\n.t Preston" 12 80
}

### THE ACTUAL SCRIPT ###

### This is how everything happens in an intuitive format and order.

# Check if user is root on Arch distro. Install dialog.
initialcheck

# Welcome user.
welcomemsg || { clear; exit; }

# Get and verify username and password.
getuserandpass

# Give warning if user already exists.
usercheck || { clear; exit; }

# Last chance for user to back out before install.
preinstallmsg || { clear; exit; }

### The rest of the script requires no user input.

adduserandpass

# Refresh Arch keyrings.
refreshkeys

# Allow user to run sudo without password. Since AUR programs must be installed
# in a fakeroot environment, this is required for all builds with AUR.
newperms "%wheel ALL=(ALL) NOPASSWD: ALL"

dialog --title "PARBS Installation" --infobox "Installing \`basedevel\` and \`git\` for installing other software." 5 70
pacman --noconfirm --needed -S base-devel git >/dev/null 2>&1

manualinstall $aurhelper

# The command that does all the installing. Reads the progs.csv file and
# installs each needed program the way required. Be sure to run this only after
# the user has been created and has priviledges to run sudo without a password
# and all build dependencies are installed.
installationloop

# Install the dotfiles in the user's home directory
putgitrepo "$dotfilesrepo" "/home/$name"

# Pulseaudio, if/when initially installed, often needs a restart to work immediately.
[ -f /usr/bin/pulseaudio ] && resetpulse

#copy rofi theme
cp /home/$name/.config/rofi/bmenu.rasi /usr/share/rofi/> /dev/null

# Enable services here.
serviceinit NetworkManager cronie

# Most important command! Get rid of the beep!
systembeepoff

#install fonts
dialog --infobox "Installing fonts..." 4 50
cd /etc/fonts/conf.d/> /dev/null
sudo rm /etc/fonts/conf.d/10* && sudo rm -rf 70-no-bitmaps.conf && sudo ln -s ../conf.avail/70-yes-bitmaps.conf> /dev/null

#scientifica
sudo cp -avr /home/$name/fon/bitmap-fonts/bitmap/ /usr/share/fonts
ln -fs /home/$name/fon/scientifica/regular/scientifica-11.bdf /usr/share/fonts/scientifica-11.bdf > /dev/null
ln -fs /home/$name/fon/scientifica/bold/scientifica-11.bdf /usr/share/fonts/scientificaBold-11.bdf > /dev/null
fc-cache -fv > /dev/null

# This line, overwriting the `newperms` command above will allow the user to run
# serveral important commands, `shutdown`, `reboot`, updating, etc. without a password.
newperms "%wheel ALL=(ALL) ALL\\n%wheel ALL=(ALL) NOPASSWD: /usr/bin/make,/usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/packer -Syu,/usr/bin/packer -Syyu,/usr/bin/systemctl restart NetworkManager,/usr/bin/rc-service NetworkManager restart,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/yay,/usr/bin/pacman -Syyuw --noconfirm"

# Make pacman and yay colorful because why not.
sed -i "s/^#Color/Color/g" /etc/pacman.conf

sudo -u "$name" mkdir \
  /home/$name/doc \
  /home/$name/doc/src \
  /home/$name/doc/pdf \
  /home/$name/doc/rep \
  /home/$name/pix \
  /home/$name/snd \
  /home/$name/dwn \
  /home/$name/vid

sudo -u $name unlink -s \
	/home/$name/cfg/config \
	/home/$name/cfg/scripts \
	/home/$name/thm/mondo

sudo -u $name ln -s /home/$name/.config/ /home/$name/cfg/config
sudo -u $name ln -s /home/$name/scr/ /home/$name/cfg/scripts
sudo -u $name ln -s /home/$name/.config/mondo/themes/ /home/$name/thm/mondo

chmod -R $name /home/$name

sudo -u $name mondo -fg all
sudo -u $name mondo -a $(mondo -l themes | head -1)
sudo -u $name preset load mondo

pacman --noconfirm --needed -U https://archive.org/download/archlinux_pkg_pango/pango-1.43.0-1-x86_64.pkg.tar.xz 

# Last update! then Install complete!
finalize
clear
