{ pkgs, ... }: {
  home.username = "kamek";
  home.homeDirectory = "/home/kamek";

  home.packages = with pkgs; [
    openssh
    awscli2
    jq # JSON CLI tool
    bat # Alternative to cat
    tokei # Lines of code reporter
    hexyl # Hex viewer
    gitleaks # Check a repository for secrets

    # Nix language server, code formatter and tools
    nil
    nixpkgs-fmt
    nix-prefetch
    nix-prefetch-git
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
