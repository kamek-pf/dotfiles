{ settings, ... }: {
  # The actual shell
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    environmentVariables = settings.env;
  };

  # Starship implements a fast, configurable prompt
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      nix_shell.format = "via [❄️ nix shell](bold blue) ";
      git_status = {
        deleted = "x";
      };
    };
  };

  # Atuin implements tooling for looking up previous commands
  programs.atuin = {
    enable = true;
    # Disable up arrow, some extra keybindings are handled by Nushell directly:
    # - Ctrl + Up shows a small inline interface
    # - Ctrl + A shows the fullscreen interface
    flags = [ "--disable-up-arrow" ];
    settings = {
      sync_address = "http://core:8888";
      filter_mode = "directory";
      show_help = false;
      prefers_reduced_motion = true;
    };
  };

  # Carapace provides command argument completion
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Direnv manages and loads variables from env files when changing directory
  programs.direnv = {
    enable = true;
    config = {
      load_dotenv = true;
    };
    nix-direnv.enable = true;
  };
}
