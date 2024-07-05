{ ... }: {
  system.stateVersion = "23.11";
  networking.hostName = "antharas";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    ./hardware-configuration.nix
    ../workstation.nix
    ../../modules/hyprland-wm.nix
    ../../modules/river-wm.nix
    ../../modules/games.nix
  ];
}

