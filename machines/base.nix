# Base settings that apply to all machines, including headless servers.
{ pkgs, ... }: {
  # Keep the bootloader clean
  boot.loader.systemd-boot.configurationLimit = 5;

  nix = {
    settings = {
      trusted-users = [ "root" "kamek" ];
      experimental-features = [ "nix-command" "flakes" ];
    };

    # Optimise store to remove duplicates
    optimise = {
      automatic = true;
      dates = [ "17:15" ];
    };

    # Remove old generations periodically
    gc = {
      automatic = true;
      dates = "17:40";
      options = "--delete-older-than 7d";
    };
  };

  time.timeZone = "America/Montreal";

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  users.users.kamek = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = [ "wheel" "networkmanager" "video" "scanner" "lp" ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    # BTRFS settings
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };

    # SSH and VPN
    openssh.enable = true;
    tailscale.enable = true;
  };

  # Enable Docker support
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  # Global environment variables  
  environment.sessionVariables = {
    EDITOR = "hx";
  };

  # Global packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    nushell
    helix
    git
    fd
    ripgrep
    dua
    usbutils
    pciutils
  ];

  # Show diff on update
  system.activationScripts.diff = ''
    if [[ -e /run/current-system ]]; then
      ${pkgs.nix}/bin/nix store diff-closures /run/current-system "$systemConfig"
    fi
  '';
}

