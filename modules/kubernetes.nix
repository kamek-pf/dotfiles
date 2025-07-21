{ pkgs, ... }:
let
  colors = import ./colors.nix;
  foreground = colors.varua.foreground;
  background = colors.varua.background;
in
{
  home.packages = with pkgs; [
    kubectl
  ];

  programs.k9s = {
    enable = true;
    hotKeys = {
      showNodes = {
        shortCut = "Shift-1";
        description = "Show nodes";
        command = "nodes";
      };
      showDeploys = {
        shortCut = "Shift-2";
        description = "Show deployments";
        command = "dp";
      };
      showPods = {
        shortCut = "Shift-3";
        description = "Show pods";
        command = "pods";
      };
    };
    settings.k9s.ui = {
      skin = "varua";
      logoless = true;
      noIcons = true;
    };
    skins.varua.k9s = with colors.varua.normal; {
      body = {
        fgColor = foreground;
        bgColor = background;
        logoColor = blue;
      };
      prompt = {
        fgColor = foreground;
        bgColor = background;
        suggestColor = yellow;
      };
      info = {
        fgColor = magenta;
        sectionColor = foreground;
      };
      help = {
        fgColor = foreground;
        bgColor = background;
        keyColor = magenta;
        numKeyColor = blue;
        sectionColor = green;
      };
      dialog = {
        fgColor = foreground;
        bgColor = background;
        buttonFgColor = foreground;
        buttonBgColor = magenta;
        buttonFocusFgColor = foreground;
        buttonFocusBgColor = cyan;
        labelFgColor = yellow;
        fieldFgColor = foreground;
      };
      frame = {
        border = {
          fgColor = foreground;
          focusColor = foreground;
        };
        menu = {
          fgColor = foreground;
          keyColor = magenta;
          numKeyColor = magenta;
        };
        crumbs = {
          fgColor = foreground;
          bgColor = background;
          activeColor = black;
        };
        status = {
          newColor = cyan;
          modifyColor = blue;

          addColor = green;
          errorColor = red;
          highlightColor = yellow;
          killColor = background;
          completedColor = background;
        };
        title = {
          fgColor = foreground;
          bgColor = background;
          highlightColor = yellow;
          counterColor = blue;
          filterColor = magenta;
        };
      };
      views = {
        charts = {
          bgColor = background;
          defaultDialColors = [ blue red ];
          defaultChartColors = [ blue red ];
        };
        table = {
          fgColor = foreground;
          bgColor = background;
          cursorFgColor = background;
          cursorBgColor = background;
          header = {
            fgColor = foreground;
            bgColor = background;
            sorterColor = foreground;
          };
        };
        xray = {
          fgColor = foreground;
          bgColor = background;
          cursorColor = foreground;
          graphicColor = blue;
          showIcons = false;
        };
        yaml = {
          keyColor = magenta;
          colonColor = blue;
          valueColor = foreground;
        };
        logs = {
          fgColor = foreground;
          bgColor = background;
          indicator = {
            fgColor = foreground;
            bgColor = background;
          };
        };
      };
    };
  };
}
