{ pkgs, settings, ... }: {
  home.packages = with pkgs; [
    openssh
    awscli2
    google-cloud-sdk
    unzip
    ripgrep # Faster grep
    jq # JSON CLI tool
    fd # Alternative to find
    bat # Alternative to cat
    tokei # Lines of code reporter
    hexyl # Hex viewer
    gitleaks # Check a repository for secrets
    termshark # Network analysis and packet capture
    # claude-code # Agentic coding tool by Anthropic

    # Nix tools
    nix
    nixpkgs-fmt
    nix-prefetch
    nix-prefetch-git

    # Language servers
    nil # Nix
    taplo # TOML
    harper # Grammar checker
    marksman # Markdown
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
  ];

  age = {
    identityPaths = [ "/home/${settings.username}/.ssh/id_ed25519" ];
    secrets = {
      anthropic-key.file = ../secrets/anthropic-key.age;
      aws-config.file = ../secrets/aws-config.age;
      "openvpn-infillion.ovpn.age".file = ../secrets/openvpn-infillion.ovpn.age;
    };
  };

  # Import CLI tool configs
  imports = [
    ./ssh.nix
    ./btop.nix
    ./git.nix
    ./helix.nix
    ./shell.nix
    ./kubernetes.nix
    ./aider.nix
  ];
}
