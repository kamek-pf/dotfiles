{ ... }:
let
  colors = (import ./colors.nix).varua;
  fontStyle = {
    family = "JetbrainsMono";
    style = "Regular";
  };
in
{
  programs.alacritty = {
    enable = true;
    settings.shell.program = "nu";

    settings.font = {
      size = 11.5;
      normal = fontStyle;
      italic = fontStyle;
      bold = fontStyle;
    };

    settings.colors = {
      primary.background = colors.background;
      primary.foreground = colors.foreground;
      normal = colors.normal;
      bright = colors.bright;
    };

    settings.window = {
      opacity = 1;
      dimensions = {
        columns = 80;
        lines = 24;
      };
      padding = {
        x = 10;
        y = 4;
      };
    };
  };
}
