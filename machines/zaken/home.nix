{ ... }: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    ../../modules/window-manager.nix
    ../../modules/common.nix
    ../../modules/gui.nix
    ../../modules/music.nix
  ];
}
