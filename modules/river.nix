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
          (desktopMonitor "DP-2" // {
            position = "-1440,-450";
            transform = "90";
          })
        ];
      }];
  };

  wayland.windowManager.river =
    let
      mod = key: "Mod4 " + key; # Super + key
      modCtrl = key: "Mod4+Control " + key; # Super + Control + key
      modShift = key: "Mod4+Shift " + key; # Super + Control + key
      spawn = cmd: "spawn '${cmd}'";
    in
    {
      enable = true;
      settings = {
        default-layout = "rivertile";
        focus-follows-cursor = "normal";
        spawn = [ "rivertile" "waybar" "kanshi" ];
        map.normal = {
          # Window navigation
          ${mod "up"} = "focus-view up";
          ${mod "down"} = "focus-view down";
          ${mod "left"} = "focus-view left";
          ${mod "right"} = "focus-view right";
          ${mod "w"} = "close";
          ${mod "z"} = "zoom";
          ${mod "x"} = "toggle-float";
          ${mod "a"} = "toggle-fullscreen";
          # Move view to monitor
          ${modShift "left"} = "send-to-output left";
          ${modShift "right"} = "send-to-output right";
          # Tags / workspaces
          ${mod "1"} = "set-focused-tags 1";
          ${mod "2"} = "set-focused-tags 2";
          ${mod "3"} = "set-focused-tags 4";
          ${mod "4"} = "set-focused-tags 8";
          ${mod "5"} = "set-focused-tags 16";
          ${mod "6"} = "set-focused-tags 32";
          # Move view to workspace
          ${modShift "1"} = "set-view-tags 1";
          ${modShift "2"} = "set-view-tags 2";
          ${modShift "3"} = "set-view-tags 4";
          ${modShift "4"} = "set-view-tags 8";
          ${modShift "5"} = "set-view-tags 16";
          ${modShift "6"} = "set-view-tags 32";
          # Change layout
          ${modShift "up"} = "send-layout-cmd rivertile 'main-location-top'";
          ${modShift "down"} = "send-layout-cmd rivertile 'main-location-left'";
          # Monitor focus
          ${modCtrl "left"} = "focus-output left";
          ${modCtrl "right"} = "focus-output right";
          # Launch apps
          ${mod "return"} = spawn "alacritty";
          ${mod "space"} = spawn "wofi --show drun --insensitive";
          # Misc
          "Control+Alt escape" = "exit";
        };
      };
    };
}
