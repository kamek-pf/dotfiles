{
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
