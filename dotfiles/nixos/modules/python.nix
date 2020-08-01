{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python3
    pypy3
    poetry
  ];
}

