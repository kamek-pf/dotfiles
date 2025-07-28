# Default settings. Machines can override any subset of this record.
{
  # Machine username
  username = "kamek";
  git = {
    username = "kamek-pf";
    email = "b.kamek@gmail.com";
  };
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
