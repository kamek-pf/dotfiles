# This is a NixOS module. To import River configurations with
# home-manager, you'll need the river.nix module as well.
{ osConfig, ... }:
let
  # Aliases
  host = osConfig.networking.hostName;
  hostMouse = cfg.${host}.mouse;

  # riverctl helpers
  mod = key: "Super " + key; # Super + key
  modCtrl = key: "Super+Control " + key; # Super + Control + key
  modShift = key: "Super+Shift " + key; # Super + Shift + key
  modAlt = key: "Super+Alt " + key; # Super + Alt + key
  spawn = cmd: "spawn '${cmd}'";
  exec = cmd: "'${cmd}'";

  # Host specific configs
  cfg.antharas =
    let
      leftMonitorX = "-1440";
      leftMonitorY = "-450";
      leftMonitorPos = "${leftMonitorX},${leftMonitorY}";
      monitorPos = "wlr-randr --output DP-2 --pos";
      cursorWarp = "riverctl set-cursor-warp";
      desktopMonitor = criteria: {
        inherit criteria;
        status = "enable";
        scale = 1.5;
        mode = "3840x2160@60Hz";
      };
    in
    {
      mouse = "pointer-1133-49738-Logitech_Gaming_Mouse_G600";
      bindings = {
        # Switch to game mode / regular mode
        ${modAlt "left"} = spawn "${monitorPos} -5000,${leftMonitorY}; ${cursorWarp} on-output-change; dunstctl set-paused true";
        ${modAlt "right"} = spawn "${monitorPos} ${leftMonitorPos}; ${cursorWarp} disabled; dunstctl set-paused false";
      };
      riverExtra = ''
        riverctl focus-output left
        riverctl send-layout-cmd rivertile 'main-location top';
        riverctl send-layout-cmd rivertile 'main-ratio 0.678'
        riverctl focus-output right
      '';
      kanshiSettings = [{
        profile.outputs = [
          (desktopMonitor "DP-1")
          (desktopMonitor "DP-2" // {
            position = leftMonitorPos;
            transform = "90";
          })
        ];
      }];
    };

  cfg.zaken = {
    mouse = "pointer-1739-0-Synaptics_TM3289-021";
    bindings = { };
    riverExtra = "";
    kanshiSettings = [{
      profile.outputs = [{
        criteria = "eDP-1";
        status = "enable";
        scale = 1.25;
        mode = "2560x1440@60Hz";
      }];
    }];
  };
in
{
  services.kanshi = {
    enable = true;
    settings = cfg.${host}.kanshiSettings;
  };

  wayland.windowManager.river = {
    enable = true;
    extraConfig = cfg.${host}.riverExtra;
    settings = {
      default-layout = "rivertile";
      default-attach-mode = "bottom";
      keyboard-layout = "-options 'compose:ralt' us";
      spawn = map exec [
        "rivertile"
        "waybar"
        "kanshi"
        "swaybg -m fill -i ~/Dev/dotfiles/wallpapers/sea.jpg"
        "wl-paste --type text --watch cliphist store"
      ];
      input.${hostMouse} = {
        "accel-profile" = "none";
        "pointer-accel" = "0";
      };
      map.normal = cfg.${host}.bindings // {
        # Window navigation
        ${mod "up"} = "focus-view up";
        ${mod "down"} = "focus-view down";
        ${mod "left"} = "focus-view left";
        ${mod "right"} = "focus-view right";
        ${mod "w"} = "close";
        ${mod "z"} = "zoom";
        ${mod "a"} = "toggle-fullscreen";
        ${mod "v"} = "toggle-float";
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
        # Launch apps and tools
        ${mod "l"} = spawn "swaylock -f";
        ${mod "return"} = spawn "alacritty";
        ${mod "space"} = spawn "wofi --show drun --insensitive";
        ${mod "c"} = spawn "cliphist list | wofi --show dmenu --insensitive | cliphist decode | wl-copy";
        ${mod "x"} = spawn "cliphist list | wofi --show dmenu --insensitive | cliphist decode | bash";
        ${mod "print"} = spawn "grim -g \"$(slurp -d)\" - | wl-copy";
        ${modCtrl "print"} = spawn "grim -g \"$(slurp -d)\" - | swappy -f - -o - | wl-copy";
        ${modAlt "print"} = spawn "record-start";
        ${modShift "print"} = spawn "record-stop";
        # Misc
        "Control+Alt escape" = "exit";
      };
    };
  };
}
