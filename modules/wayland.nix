# This is a home-manager module for Wayland based window managers.
{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Screenshot stuff
    grim # capture screenshot
    slurp # select zone on screen
    swappy # quick editing tool

    # Clipboard tools
    cliphist # clipboard manager
    wl-clipboard # clipboard interactions

    # Wayland monitor tools
    kanshi
    wlr-randr
  ];

  imports = [
    ./dunst.nix
    ./waybar.nix
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
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
  };
}
