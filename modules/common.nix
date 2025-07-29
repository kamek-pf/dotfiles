{ pkgs, ... }: {
  home.packages = with pkgs; [
    openssh
    awscli2
    google-cloud-sdk
    unzip
    jq # JSON CLI tool
    bat # Alternative to cat
    tokei # Lines of code reporter
    hexyl # Hex viewer
    gitleaks # Check a repository for secrets
    termshark # network analysis and packet capture

    # Nix tools
    nixpkgs-fmt
    nix-prefetch
    nix-prefetch-git

    # Language servers
    nil # Nix
    taplo # TOML
    harper # Grammar checker
    marksman # Markdown
    # add nodejs AI!
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
  ];

  # Import CLI tool configs
  imports = [
    ./ssh.nix
    ./btop.nix
    ./git.nix
    ./helix.nix
    ./shell.nix
    ./kubernetes.nix
  ];
}
