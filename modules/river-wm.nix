# This is a NixOS module. To import River configurations with
# home-manager, you'll need the river.nix module as well.
{ pkgs, ... }: {
  programs.river.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
  ];
}
