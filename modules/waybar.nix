{ osConfig, ... }:
let
  host = osConfig.networking.hostName;

  config = {
    layer = "top";
    height = 35;
    spacing = 8;
    "hyprland/workspaces" = {
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "urgent" = "";
        "active" = "";
        "default" = "";
      };
      persistent-workspaces = cfg.${host}.persistent;
    };
    mpd = {
      interval = 1;
      format = "{stateIcon}{consumeIcon}{randomIcon}{repeatIcon}{singleIcon} {artist} - {album} - {title}  ";
      format-stopped = "";
      on-click = "mpc toggle";
      on-scroll-up = "mpc next";
      on-scroll-down = "mpc prev";
      random-icons.on = "  ";
      repeat-icons.on = "  ";
      single-icons.on = " 1 ";
      state-icons = {
        paused = " ";
        playing = " ";
      };
    };
    tray = {
      spacing = 10;
    };
    clock = {
      interval = 1;
      format = "{:%A, %B %d, %Y %R}";
      format-alt = "{:%Y/%m/%d %T}";
    };
    cpu = {
      format = "  {usage}%";
      tooltip = true;
    };
    memory = {
      format = "  {}%";
    };
    pulseaudio = {
      format = "{icon}  {volume}%";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
          ""
        ];
      };
      on-click = "pavucontrol";
    };
    network = {
      interval = 3;
      interface = cfg.${host}.interface;
      format = " {bandwidthDownBytes}    {bandwidthUpBytes}";
      format-disconnected = "";
      tooltip-format-disconnected = "Offline";
      tooltip-format-wifi = "  {essid} - {signalStrength}%";
    };
    disk = {
      interval = 30;
      format = "  {percentage_used}%";
      path = "/";
    };
    backlight = {
      device = "intel_backlight";
      format = "{icon}  {percent}%";
      format-icons = [ "" ];
    };
    battery = {
      bat = cfg.${host}.battery;
      interval = 60;
      format = "{icon}  {capacity}%";
      format-icons = [ "" "" "" "" "" ];
    };
    gamemode = {
      use-icon = false;
      format = "  {count}  ";
      format-alt = "  {count}  ";
      tooltip-format = "Games running: {count}";
    };
    "custom/github" = {
      interval = 1;
      exec = "busctl --user -j get-property io.ntfd /github github.strings UnreadNotifications | jq -r .data";
      format = "   {} ";
    };
  };

  cfg.antharas = {
    interface = "enp34s0";
    battery = null;
    persistent = {
      "DP-1" = [ 1 2 3 4 5 6 ];
      "DP-2" = [ 7 8 9 ];
    };
    settings.mainMonitor = config // {
      output = "DP-1";
      modules-left = [
        "hyprland/workspaces"
        "mpd"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "network"
        "pulseaudio"
        "custom/github"
        "cpu"
        "memory"
        "disk"
      ];
    };
    settings.secondaryMonitor = config // {
      output = "DP-2";
      modules-left = [
        "hyprland/workspaces"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "gamemode"
        "pulseaudio"
        "cpu"
        "memory"
        "disk"
      ];
    };
  };

  cfg.zaken = {
    interface = "wlp2s0";
    battery = "BAT0";
    persistent = {
      "eDP-1" = [ 1 2 3 4 5 ];
    };
    settings.mainMonitor = config // {
      output = "eDP-1";
      modules-left = [
        "hyprland/workspaces"
        "mpd"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "network"
        "pulseaudio"
        "custom/github"
        "backlight"
        "cpu"
        "memory"
        "disk"
        "battery"
      ];
    };
  };
in
{
  programs.waybar.enable = true;
  programs.waybar.style = ./waybar.css;
  programs.waybar.settings = cfg.${host}.settings;
}
