# This is a NixOS module
{ pkgs, ... }: {
  programs = {
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
  ];
}
