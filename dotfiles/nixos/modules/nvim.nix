{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
  ];
  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";

  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
	vimAlias = true;
      };
     })
  ];
}
