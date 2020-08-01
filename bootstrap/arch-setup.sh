#!/usr/bin/env sh -x
if [ -z "$1" ]; then
    echo "You must pass in the intended hostname!"
    exit 1
fi
set -e
PS4="\n\033[1;33m::\033[0m "; set -x

# Basic stuff
loadkeys pl
timedatectl set-ntp true

cat > /etc/locale.gen <<- EOF
en_IE.UTF-8 UTF-8
en_IE@euro ISO-8859-15
en_US.UTF-8 UTF-8
pl_PL.UTF-8 UTF-8
EOF

locale-gen

echo "LANG=en_IE.UTF-8" > /etc/locale.conf
echo "KEYMAP=pl" > /etc/vconsole.conf

echo $1 > /etc/hostname

cat > /etc/hosts <<- EOF
127.0.0.1	localhost
::1		localhost
127.0.1.1	$1.home	$1
EOF

mkinitcpio -P

# install dependencies
pacman -S grub efibootmgr sudo git jq openssh

grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

cat > /etc/sudoers.new <<- EOF
root ALL=(ALL) ALL

%wheel ALL=(ALL) NOPASSWD: ALL

## Same thing without a password
# %wheel ALL=(ALL)

#includedir /etc/sudoers.d
EOF

EDITOR="cp /etc/sudoers.new" visudo
rm /etc/sudoers.new

useradd -m -g users -G fox,wheel fox
usermod -aG fox,wheel
{ echo "Set the password now:"; } 2>/dev/null
passwd fox

git clone https://github.com/slavfox/dots.git /home/fox/dots
chown fox:fox /home/fox/dots

mkdir -p /home/fox/.ssh
curl https://api.github.com/users/slavfox/keys | \
  jq -r .[].key > /home/fox/.ssh/authorized_keys

{ echo "Done!"; } 2>/dev/null
