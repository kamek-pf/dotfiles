# This is a NixOS module. To import River configurations with
# home-manager, you'll need the river.nix module as well.
{ ... }: {
  imports = [ ./wayland.nix ];

  services.kanshi = {
    enable = true;
    settings.profile = [
      {
        output = {
          status = "enable";
          criteria = "DP-1";
          scale = 1.5;
          mode = "3840x2160@60Hz";
        };
      }
      {
        output = {
          status = "enable";
          criteria = "DP-2";
          scale = 1.5;
          mode = "3840x2160@60Hz";
          position = "0,-460";
        };
      }
    ];
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
        spawn = [ "rivertile" "waybar" ];
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
