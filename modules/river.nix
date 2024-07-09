# This is a NixOS module. To import River configurations with
# home-manager, you'll need the river.nix module as well.
{ ... }:
let
  leftMonitorX = "-1440";
  leftMonitorY = "-450";
  leftMonitorPos = "${leftMonitorX},${leftMonitorY}";
  desktopMouse = "pointer-1133-49738-Logitech_Gaming_Mouse_G600";
in
{
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
            position = leftMonitorPos;
            transform = "90";
          })
        ];
      }];
  };

  wayland.windowManager.river =
    let
      mod = key: "Mod4 " + key; # Super + key
      modCtrl = key: "Mod4+Control " + key; # Super + Control + key
      modShift = key: "Super+Shift " + key; # Super + Shift + key
      modAlt = key: "Super+Alt " + key; # Super + Alt + key
      spawn = cmd: "spawn '${cmd}'";
      monitorPos = "wlr-randr --output DP-2 --pos";
      cursorWarp = "riverctl set-cursor-warp";
    in
    {
      enable = true;
      settings = {
        default-layout = "rivertile";
        spawn = [ "rivertile" "waybar" "kanshi" "swaybg -m fill -i ~/Dev/dotfiles/wallpapers/sea.jpg" ];
        input.${desktopMouse} = {
          "accel-profile" = "none";
          "pointer-accel" = "0";
        };
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
          ${mod "kp_subtract"} = "swap previous";
          ${mod "kp_add"} = "swap next";
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
          # Move view to monitor
          ${modShift "left"} = "send-to-output left";
          ${modShift "right"} = "send-to-output right";
          # Change layout
          ${modShift "up"} = "send-layout-cmd rivertile 'main-location top'";
          ${modShift "down"} = "send-layout-cmd rivertile 'main-location left'";
          # Monitor focus
          ${modCtrl "left"} = "focus-output left";
          ${modCtrl "right"} = "focus-output right";
          # Switch to game mode / regular mode
          ${modAlt "left"} = spawn "${monitorPos} -5000,${leftMonitorY}; ${cursorWarp} on-output-change";
          ${modAlt "right"} = spawn "${monitorPos} ${leftMonitorPos}; ${cursorWarp} disabled";
          # Launch apps
          ${mod "return"} = spawn "alacritty";
          ${mod "space"} = spawn "wofi --show drun --insensitive";
          ${mod "c"} = spawn "cliphist list | wofi --show dmenu --insensitive | cliphist decode | wl-copy";
          # Misc
          "Control+Alt escape" = "exit";
        };
      };
    };
}
