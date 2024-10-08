{ ... }: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        ### Display ###

        # Which monitor should the notifications be displayed on.
        monitor = 1;

        # Display notification on focused monitor.  Possible modes are:
        #   mouse: follow mouse pointer
        #   keyboard: follow window with keyboard focus
        #   none: don't follow anything
        #
        # "keyboard" needs a window manager that exports the
        # _NET_ACTIVE_WINDOW property.
        # This should be the case for almost all modern window managers.
        #
        # If this option is set to mouse or keyboard, the monitor option
        # will be ignored.
        follow = "none";

        # The geometry of the window:
        #   [{width}]x{height}[+/-{x}+/-{y}]
        # The geometry of the message window.
        # The height is measured in number of notifications everything else
        # in pixels.  If the width is omitted but the height is given
        # ("-geometry x2"), the message window expands over the whole screen
        # (dmenu-like).  If width is 0, the window expands to the longest
        # message displayed.  A positive x is measured from the left, a
        # negative from the right side of the screen.  Y is measured from
        # the top and down respectively.
        # The width can be negative.  In this case the actual width is the
        # screen width minus the width defined in within the geometry option.
        width = "(0, 500)";
        height = 500;
        # height = ""(0, 400)";"
        offset = "20x20";

        # Show how many messages are currently hidden (because of geometry).
        indicate_hidden = "yes";

        # The transparency of the window.  Range: [0; 100].
        # This option will only work if a compositing window manager is
        # present (e.g. xcompmgr, compiz, etc.).
        transparency = 0;

        # Draw a line of "separator_height" pixel height between two
        # notifications.
        # Set to 0 to disable.
        separator_height = 2;

        # Padding between text and separator.
        padding = 15;

        # Horizontal padding.
        horizontal_padding = 15;

        # Defines width in pixels of frame around the notification window.
        # Set to 0 to disable.
        frame_width = 2;

        # Defines color of the frame around the notification window.
        frame_color = "#dfbf8e";

        # Define a color for the separator.
        # possible values are:
        #  * auto: dunst tries to find a color fitting to the background;
        #  * foreground: use the same color as the foreground;
        #  * frame: use the same color as the frame;
        #  * anything else will be interpreted as a X color.
        separator_color = "frame";

        # Sort messages by urgency.
        sort = "yes";

        # Don't remove messages, if the user is idle (no mouse or keyboard input)
        # for longer than idle_threshold seconds.
        # Set to 0 to disable.
        idle_threshold = 120;

        ### Text ###

        font = "Fira Sans Book 12.5";

        # The spacing between lines.  If the height is smaller than the
        # font height, it will get raised to the font height.
        line_height = 0;

        # Possible values are:
        # full: Allow a small subset of html markup in notifications:
        #        <b>bold</b>
        #        <i>italic</i>
        #        <s>strikethrough</s>
        #        <u>underline</u>
        #
        #        For a complete reference see
        #        <http://developer.gnome.org/pango/stable/PangoMarkupFormat.html>.
        #
        # strip: This setting is provided for compatibility with some broken
        #        clients that send markup even though it's not enabled on the
        #        server. Dunst will try to strip the markup but the parsing is
        #        simplistic so using this option outside of matching rules for
        #        specific applications *IS GREATLY DISCOURAGED*.
        #
        # no:    Disable markup parsing, incoming notifications will be treated as
        #        plain text. Dunst will not advertise that it has the body-markup
        #        capability if this is set as a global setting.
        #
        # It's important to note that markup inside the format option will be parsed
        # regardless of what this is set to.
        markup = "full";

        # The format of the message.  Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        #   %n  progress value if set without any extra characters
        # Markup is allowed
        format = "<b>%s</b>\n%b";

        # Alignment of message text.
        # Possible values are "left", "center" and "right".
        alignment = "left";

        # Show age of message if message is older than show_age_threshold
        # seconds.
        # Set to -1 to disable.
        show_age_threshold = 60;

        # Split notifications into multiple lines if they don't fit into
        # geometry.
        word_wrap = "yes";

        # Ignore newlines '\n' in notifications.
        ignore_newline = "no";

        # Merge multiple notifications with the same content
        stack_duplicates = true;

        # Hide the count of merged notifications with the same content
        hide_duplicate_count = false;

        # Display indicators for URLs (U) and actions (A).
        show_indicators = "yes";

        ### Icons ###

        # Align icons left/right/off
        icon_position = "left";

        # Scale larger icons down to this size, set to 0 to disable
        max_icon_size = "100";

        ### History ###

        # Should a notification popped up from history be sticky or timeout
        # as if it would normally do.
        sticky_history = "yes";

        # Maximum amount of notifications kept in history
        history_length = "5";

        ### Misc/Advanced ###

        # dmenu path.
        dmenu = "/usr/bin/dmenu -p dunst:";

        # Browser for opening urls in context menu.
        browser = "/usr/bin/firefox -new-tab";

        # Always run rule-defined scripts, even if the notification is suppressed
        always_run_script = true;

        # Define the title of the windows spawned by dunst
        title = "Dunst";

        # Define the class of the windows spawned by dunst
        class = "Dunst";

        ### Legacy

        # Use the Xinerama extension instead of RandR for multi-monitor support.
        # This setting is provided for compatibility with older nVidia drivers that
        # do not support RandR and using it on systems that support RandR is highly
        # discouraged.
        #
        # By enabling this setting dunst will not be able to detect when a monitor
        # is connected or disconnected which might break follow mode if the screen
        # layout changes.
        force_xinerama = false;
      };

      # Experimental features that may or may not work correctly. Do not expect them
      # to have a consistent behaviour across releases.
      experimental = {
        per_monitor_dpi = false;
      };

      urgency_low = {
        background = "#282828";
        foreground = "#dfbf8e";
        timeout = 10;
      };

      urgency_normal = {
        background = "#282828";
        foreground = "#dfbf8e";
        timeout = 10;
      };

      urgency_critical = {
        background = "#282828";
        foreground = "#dfbf8e";
        frame_color = "#ea6962";
        timeout = 0;
      };
    };
  };
}
