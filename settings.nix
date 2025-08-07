# Default settings. Machines can override any subset of this record.
{
  isNixOS = true;
  # Machine username
  username = "kamek";

  # Global environment variables
  env = {
    EDITOR = "hx";
  };

  # Git settings
  git = {
    username = "kamek-pf";
    email = "b.kamek@gmail.com";
  };

  # Window manager configs
  windowManager = rec {
    available = {
      river = "river";
      hyprland = "hyprland";
    };
    selected = available.river;
    isRiver = selected == available.river;
    isHyprland = selected == available.hyprland;
  };
}
