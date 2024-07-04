# This is a NixOS module
{ pkgs, ... }: {
  programs = {
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    noisetorch.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    vulkan-tools # allows testing with vkcube
  ];
}
