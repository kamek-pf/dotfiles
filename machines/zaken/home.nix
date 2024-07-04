{ ... }: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;


  imports = [
    ../../modules/common.nix
    ../../modules/gui.nix
    ../../modules/river.nix
    ../../modules/hyprland.nix
    ../../modules/music.nix
  ];
}
