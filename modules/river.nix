# This is a NixOS module. To import River configurations with
# home-manager, you'll need the river.nix module as well.
{ ... }: {
  imports = [ ./wayland.nix ];

  services.kanshi = {
    enable = true;
    settings =
      let
        desktopMonitor = criteria: {
          inherit criteria;
          status = "enable";
          scale = 1.5;
          mode = "3840x2160@60Hz";
        };
      in
      [{
        profile.outputs = [
          (desktopMonitor "DP-1")
          (desktopMonitor "DP-2" // { position = "-1440,450"; })
        ];
      }];
  };

  wayland.windowManager.river =
    let
      mod = key: "Mod4 " + key; # Super + key
      spawn = cmd: "spawn '${cmd}'";
    in
    {
      enable = true;
      settings = {
        default-layout = "rivertile";
        spawn = [ "rivertile" "waybar" "kanshi" ];
        map.normal = {
          ${mod "up"} = "focus-view up";
          ${mod "down"} = "focus-view down";
          ${mod "left"} = "focus-view left";
          ${mod "right"} = "focus-view right";
          ${mod "return"} = spawn "alacritty";
          ${mod "space"} = spawn "wofi --show drun --insensitive";
          ${mod "w"} = "close";
          ${mod "p"} = "exit";
        };
      };
    };
}
