{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gollum
    nginx
  ];

  services.gollum = {
    enable = true;
    port = 4327;
    stateDir = "/var/lib/gollum";
    extraConfig = ( builtins.readFile /home/fox/dots/scripts/gollum-config.rb );
  };

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
}

