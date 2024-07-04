# This is a NixOS module. To import River configurations with
# home-manager, you'll need the river.nix module as well.
{ ... }: {
  wayland.windowManager.river = {
    enable = true;
    settings = {
      default-layout = "rivertile";
      spawn = [ "rivertile" "waybar" ];
      map.normal =
        let
          mod = key: "Mod4 " + key;
          spawn = cmd: "spawn '${cmd}'";
        in
        {
          ${mod "Return"} = spawn "alacritty";
          ${mod "Space"} = spawn "wofi --show drun --insensitive";
          ${mod "W"} = "close";
          ${mod "P"} = "exit";
        };
    };
  };
}
