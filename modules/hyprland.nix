# This is a home-manager module. On NixOS you'll need to
# the hyprland-wm.nix module as well.
{ osConfig, ... }:
let
  host = osConfig.networking.hostName;
  cfg.antharas = {
    hyprpaper.wallpaper = wallpaperPath: [
      ("DP-1," + wallpaperPath)
      ("DP-2," + wallpaperPath)
    ];
    hyprland = {
      monitor = [
        "DP-1, 3840x2160@60, auto, 1.5"
        "DP-2, 3840x2160@60, 0x-460, 1.5, transform, 1"
      ];
      workspace = [
        # Workspaces for the main monitor
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        # Workspaces for the secondary monitor
        "7, monitor:DP-2"
        "8, monitor:DP-2"
        "9, monitor:DP-2"
      ];
      env = [
        "GDK_SCALE,2"
      ];
    };
  };
  cfg.zaken = {
    hyprpaper.wallpaper = wallpaperPath: [
      ("eDP-1," + wallpaperPath)
    ];
    hyprland = {
      monitor = [
        "eDP-1, preferred, auto, 1.25"
      ];
      workspace = [
        "1, monitor:eDP-1"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "6, monitor:eDP-1"
      ];
      env = [
        "GDK_SCALE,1"
      ];
    };
  };
in
{
  services.hyprpaper = {
    enable = true;
    settings =
      let wallpaperPath = "~/Dev/dotfiles/wallpapers/sea.jpg";
      in {
        splash = false;
        preload = wallpaperPath;
        wallpaper = cfg.${host}.hyprpaper.wallpaper wallpaperPath;
      };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "alacritty";
      "$fileManager" = "nautilus";
      "$launcher" = "wofi --show drun --insensitive";
      "$mainMod" = "SUPER";

      exec-once = [
        "hyprpaper & waybar & dunst"
        "wl-paste --type text --watch cliphist store"
        "hyprctl setcursor 'Adwaita' 24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = true;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      input = {
        kb_layout = "us";
        kb_options = "compose:ralt";
        follow_mouse = 2;
        numlock_by_default = true;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      cursor.no_warps = true;

      env = cfg.${host}.hyprland.env ++ [
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "WLR_DRM_NO_ATOMIC,1"
        "XCURSOR_SIZE,24"
      ];

      # This and the GDK_SCALE env variable fix blurry text in XWayland apps
      xwayland.force_zero_scaling = true;

      monitor = cfg.${host}.hyprland.monitor;
      workspace = cfg.${host}.hyprland.workspace;

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 9, fluent_decel, fade"
        ];
      };

      bind = [
        ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        "CTRL, Print, exec, grim -g \"$(slurp -d)\" - | swappy -f - -o - | wl-copy"
        "SUPER, C, exec, cliphist list | wofi --show dmenu --insensitive | cliphist decode | wl-copy"

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, SPACE, exec, $launcher"
        "$mainMod, W, killactive,"
        "$mainMod ALT, ESCAPE, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, T, togglefloating,"
        "$mainMod, A, fullscreen"
        "$mainMod, S, togglesplit, # dwindle"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move window with mainMod + shift + arrow key
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        # Main monitor
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        # Secondary monitor, controlled in reverse order
        "$mainMod, 0, workspace, 7"
        "$mainMod, 9, workspace, 8"
        "$mainMod, 8, workspace, 9"

        # Main
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        # Secondary
        "$mainMod SHIFT, 0, movetoworkspace, 7"
        "$mainMod SHIFT, 9, movetoworkspace, 8"
        "$mainMod SHIFT, 8, movetoworkspace, 9"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Allow tearing for some games
      windowrulev2 = [
        "immediate, class:^(gamescope)$" # Games running through Gamescope
        "immediate, class:^(steam_app_1172470)$" # Apex
      ];
    };
  };
}
