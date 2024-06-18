# This is a NixOS module. To import Hyprland configurations with
# home-manager, you'll need the hyprland.nix module as well.
{ pkgs, ... }: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
}
