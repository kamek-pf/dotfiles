# This is a home-manager module. It controls which window manager config should be included.
{ pkgs, ... }:
let
  wm = (import ../settings.nix).windowManager;
  wmConfig =
    if wm.isRiver then
      [ ./river.nix ]
    else if wm.isHyprland then
      [ ./hyprland.nix ]
    else
      [ ];
in
{
  home.packages = with pkgs; [
    # Screenshot and capture stuff
    grim # capture screenshot
    slurp # select zone on screen
    swappy # quick editing tool
    wf-recorder # screen recorder

    # Clipboard tools
    cliphist # clipboard manager
    wl-clipboard # clipboard interactions

    # Wayland monitor tools
    kanshi
    swaybg
    wlr-randr
  ];

  imports = wmConfig ++ [
    ./dunst.nix
    ./waybar.nix
    ./swaylock.nix
  ];

  programs.wofi = {
    enable = true;
    style = builtins.readFile ./wofi.css;
    settings = {
      height = 600;
      width = 800;
    };
  };

  home.pointerCursor = {
    name = "Adwaita";
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };
}
