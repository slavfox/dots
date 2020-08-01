#!/usr/bin/env sh -x
if [ -z "$1" ]; then
    echo "You must pass in the path to your intended boot drive!"
    exit 1
fi
PS4="\n\033[1;33m::\033[0m "; set -x
# Actual partitioning
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 512MiB -8GiB
parted /dev/sda -- mkpart primary linux-swap -8GiB 100%
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 3 boot on
# Filesystems
mkfs.ext4 -L arch /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3
swapon /dev/sda2
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
