{ settings, ... }: {
  programs.git = {
    enable = true;
    userEmail = settings.git.email;
    userName = settings.git.username;
    extraConfig = {
      # Create new branches upstream automatically
      push.autoSetupRemote = true;
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.git.lfs = {
    enable = true;
  };

  programs.git.delta = {
    enable = true;
    options = {
      syntax-theme = "base16";
      navigate = true;
      light = false;
      line-numbers = true;
      side-by-side = true;
    };
  };
}
