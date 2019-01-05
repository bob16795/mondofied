passwd

TZuser=$(cat tzfinal.tmp)

ln -sf /usr/share/zoneinfo/$TZuser /etc/localtime

hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
locale-gen

pacman --noconfirm --needed -S networkmanager
systemctl enable NetworkManager
systemctl start NetworkManager

pacman --noconfirm --needed -S grub && grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg

pacman --noconfirm --needed -S dialog

sudo ln -fs ~/fon/scientifica/regular/scientifica-11.bdf /usr/share/fonts/scientifica-11.bdf
sudo ln -fs ~/fon/scientifica/bold/scientifica-11.bdf /usr/share/fonts/scientificaBold-11.bdf

sudo pacman -S pip
pip install yay
yay -S alacritty

