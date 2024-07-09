# This is a NixOS module. It controls which window manager should be enabled
# at the OS level and what dependencies should be included.
{ pkgs, ... }:
let
  wm = (import ../settings.nix).windowManager;
  desktopPortal = with pkgs; if wm.isRiver then
    [ xdg-desktop-portal-wlr ]
  else if wm.isHyprland then
    [ xdg-desktop-portal-hyprland ]
  else [ ];
in
{
  programs.river.enable = wm.isRiver;
  programs.hyprland.enable = wm.isHyprland;

  environment.systemPackages = with pkgs; desktopPortal ++ [
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];
}
