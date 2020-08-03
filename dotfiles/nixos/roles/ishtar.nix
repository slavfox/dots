{ config, pkgs, ... }:
{

  imports = [
    ./common.nix
  ];
  
  environment.systemPackages = with pkgs; [
    gollum
    nginx
  ];

  services.gollum = {
    enable = true;
    port = 4327;
    stateDir = "/home/fox/gollum";
    extraConfig = ( builtins.readFile /home/fox/dots/scripts/gollum-config.rb );
  };

  systemd.services.gollum.serviceConfig.User = pkgs.lib.mkForce "fox";
  systemd.services.gollum.serviceConfig.Group = pkgs.lib.mkForce "users";

  services.nginx.enable = true;

  services.nginx.virtualHosts."wiki.ishtar.home" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:4327";
    };
  };

  users.users.fox = {
    extraGroups = [ "gollum" ];
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.extraHosts = 
    ''
      127.0.0.1 wiki.ishtar.home
    '';
}

