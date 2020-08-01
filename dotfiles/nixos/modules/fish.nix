{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fish
    starship
    gitAndTools.hub
  ];

  programs.fish.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/fish";
}
