# Settings I want on a regular workstation.
input@{ pkgs, config, ... }:
let
  tools = import ../tools.nix;
  scripts = import ../scripts.nix input;
in
{
  hardware = {
    # Explicitly disable PulseAudio, PipeWire is enabled below
    pulseaudio.enable = false;
    # Scanner support
    sane = {
      enable = true;
      brscan4 = {
        enable = true;
        netDevices.home = { model = "MFC-9330CDW"; ip = "192.168.0.200"; };
      };
    };
  };

  services = {
    # Sound support
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Login manager and basic desktop environment
    xserver = {
      enable = true;
      xkb.layout = "us";
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    # Printer support
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  programs = {
    openvpn3.enable = true;
  };

  # Global environment variables and paths to decrypted secrets  
  environment.sessionVariables = {
    VISUAL = "hx";
    NIXOS_OZONE_WL = "1";
    AWS_CONFIG_FILE = config.age.secrets.aws-config.path;
    INFILLION_OVPN = config.age.secrets."openvpn-infillion.ovpn".path;
  };

  # Packages that are not in home manager or don't require configuration
  environment.systemPackages = with pkgs; [
    firefox
    chromium
    discord
    jetbrains.datagrip
    mpv
    mpc-cli
    pavucontrol
    streamlink
    scripts.twitch
  ];

  fonts.packages = with pkgs; [
    fira
    jetbrains-mono
    font-awesome
  ];

  age.secrets = with tools;
    userSecret "openvpn-infillion.ovpn" //
    userSecret "aws-config";

  imports = [
    ./base.nix
  ];
}

