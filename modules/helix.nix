{ ... }: {
  programs.helix = {
    enable = true;

    # Editor config
    settings = {
      theme = "varua";
      editor = {
        true-color = true;
        auto-completion = false;
        cursorline = true;
        color-modes = true;
        bufferline = "multiple";
        gutters = [ "diff" "diagnostics" "spacer" "line-numbers" "spacer" ];
        search = {
          smart-case = false;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        statusline = {
          left = [ "mode" "spacer" "spinner" ];
          center = [ "file-name" ];
          right = [ "version-control" "spacer" "spacer" "diagnostics" "selections" "primary-selection-length" "position" "file-encoding" "file-type" ];
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = false;
        };
        soft-wrap = {
          enable = true;
        };
      };
      keys = {
        normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
          "C-up" = [ "scroll_up" "scroll_up" ];
          "C-down" = [ "scroll_down" "scroll_down" ];
          "C-d" = [ "keep_primary_selection" "move_prev_word_start" "move_next_word_end" "search_selection" "select_mode" ];
        };
        insert = {
          "C-left" = "move_prev_word_end";
          "C-right" = "move_next_word_start";
        };
        select = {
          "C-d" = [ "search_selection" "extend_search_next" ];
        };
      };
    };

    # Language settings
    languages = {
      language = [
        {
          name = "haskell";
          auto-format = true;
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "nix";
          auto-format = true;
          formatter = { command = "nixpkgs-fmt"; };
        }
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "json";
          auto-format = true;
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "sql";
          language-servers = [ "sqls" ];
        }
      ];

      # Language server specific configs
      language-server = {
        haskell-language-server = {
          config.haskell = {
            formattingProvider = "fourmolu";
            plugin.stan = { globalOn = false; };
          };
        };
        rust-analyzer = {
          config = { checkOnSave.command = "clippy"; formatOnSave = true; };
        };
        sqls = {
          command = "sqls";
        };
      };
    };
  };

  programs.sqls = {
    enable = true;
    settings = {
      lowercaseKeywords = true;
      connections = [{
        driver = "postgresql";
        dataSourceName = "host=127.0.0.1 port=5432 user=postgres dbname=postgres sslmode=disable";
      }];
    };
  };
}
