# This is a NixOS module. It controls which window manager should be enabled
# at the OS level and what dependencies should be included.
{ pkgs, ... }:
let
  wm = (import ../settings.nix).windowManager;
in
{
  programs.river.enable = wm.isRiver;
  programs.hyprland.enable = wm.isHyprland;

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = "wlr";
      };
    };
    wlr.enable = wm.isRiver;
    wlr.settings.screencast = {
      output_name = "DP-1";
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    };
  };
}
