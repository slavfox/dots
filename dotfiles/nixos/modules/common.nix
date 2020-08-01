{ config, pkgs, ... }:
{
  i18n.defaultLocale = "en_IE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  time.timeZone = "Europe/Warsaw";

  environment.systemPackages = with pkgs; [
    ag
    git
    lsof
    wget
    file
  ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;
  users.users.fox = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}

