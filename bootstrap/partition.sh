#!/usr/bin/env sh -x
if [ -z "$1" ]; then
    echo "You must pass in the path to your intended boot drive!"
    exit 1
fi
set -e
PS4="\n\033[1;33m::\033[0m "; set -x
# Actual partitioning
parted $1 -- mklabel gpt
parted $1 -- mkpart primary 512MiB -8GiB
parted $1 -- mkpart primary linux-swap -8GiB 100%
parted $1 -- mkpart ESP fat32 1MiB 512MiB
parted $1 -- set 3 boot on
# Filesystems
mkfs.ext4 -L arch "${1}1"
mkswap -L swap "${1}2"
mkfs.fat -F 32 -n boot "${1}3"
swapon "${1}2"
mount /dev/disk/by-label/arch /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
{ set +x; } 2>/dev/null
{
  . /etc/os-release
  PS4="\n\033[1;33m::\033[0m "; set -x
  if [ "$ID" == "arch" ]; then
    pacstrap /mnt base linux linux-firmware grub efibootmgr
    genfstab -U /mnt >> /mnt/etc/fstab
    { set +x; } 2>/dev/null
    echo "Done!"
    echo "Update your /etc/pacman.d/mirrorlist now."
    echo "When you want to set up Arch, arch-chroot into /mnt and run:"
    echo "  curl -L git.io/fox-arch | bash -s <intended hostname>"
  else
    nixos-generate-config --root /mnt
    { set +x; } 2>/dev/null
    echo "Done!"
    echo "Update your /etc/nixos/configuration.nix now."
    echo "When you want to set up NixOS, run:"
    echo "  nixos-install"
  fi
}
