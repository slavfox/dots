{ config, pkgs, ... }:
{
  imports =
    [
      ../modules/common.nix
      ../modules/sshd.nix
      ../modules/fish.nix
      ../modules/nvim.nix
      ../modules/python.nix
    ];
}
