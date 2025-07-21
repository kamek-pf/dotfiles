{ user, ... }: {
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
  home.username = user;
  home.homeDirectory = "/home/${user}";

  imports = [
    ../../modules/window-manager.nix
    ../../modules/common.nix
    ../../modules/gui.nix
    ../../modules/music.nix
  ];
}
