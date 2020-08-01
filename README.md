# dots

Hi. This is my dotfiles repo, which also doubles as an Ansible setup that
lets me manage my machines extremely easily.

Clone the repo to `/home/fox/dots`, then run `bin/sync-dots`!

## System setup

If you only need a basic partitioning scheme (512MiB UEFI boot at the start
of the disk, 8GiB swap at the end, root everything in-between), run:

    curl -L git.io/fox-partition | bash -s /dev/sda

For Arch, enter the `arch-chroot` and run:

    curl -L git.io/fox-arch | bash -s <intended hostname>

For NixOS, finish the installation, then log in as `fox` and run:

    curl -L git.io/fox-nixos | bash

# Credits

The awesomewm theme bases heavily on Powerarrow Dark, from
[lcpz/awesome-copycats](https://github.com/lcpz/awesome-copycats).

The wallpaper comes from [a post by /u/Leogonnagiveittoyou](https://redd.it/cw8gam)
on Reddit, although that's probably not the original source.
