{ config, lib, modulesPath, ... }:
let btrfsFlags = [ "compress=zstd" "noatime" ];
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0398f113-e458-4f55-889c-6063ab65b4d0";
    fsType = "btrfs";
    options = [ "subvol=root" ] ++ btrfsFlags;
  };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/7421ed0f-4bae-4c74-b315-b8d771d8c66d";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/0398f113-e458-4f55-889c-6063ab65b4d0";
    fsType = "btrfs";
    options = [ "subvol=home" ] ++ btrfsFlags;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/0398f113-e458-4f55-889c-6063ab65b4d0";
    fsType = "btrfs";
    options = [ "subvol=nix" ] ++ btrfsFlags;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/0398f113-e458-4f55-889c-6063ab65b4d0";
    fsType = "btrfs";
    options = [ "subvol=log" ] ++ btrfsFlags;
  };

  fileSystems."/var/lib" = {
    device = "/dev/disk/by-uuid/0398f113-e458-4f55-889c-6063ab65b4d0";
    fsType = "btrfs";
    options = [ "subvol=lib" ] ++ btrfsFlags;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/09E1-8663";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/0398f113-e458-4f55-889c-6063ab65b4d0";
    fsType = "btrfs";
    options = [ "subvol=swap" ];
  };

  fileSystems."/mnt/media" = {
    device = "core:/media";
    fsType = "nfs";
  };

  swapDevices = [{ device = "/swap/swapfile"; }];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
