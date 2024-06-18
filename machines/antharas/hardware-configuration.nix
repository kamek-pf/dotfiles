{ config, lib, modulesPath, ... }:
let btrfsFlags = [ "compress=zstd" "noatime" ];
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b456c1e9-a281-4e19-b39d-9e7490bb5298";
    fsType = "btrfs";
    options = [ "subvol=root" ] ++ btrfsFlags;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/b456c1e9-a281-4e19-b39d-9e7490bb5298";
    fsType = "btrfs";
    options = [ "subvol=nix" ] ++ btrfsFlags;
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/8e18688a-b52a-46a6-a137-b664282325eb";
    fsType = "btrfs";
    options = [ "subvol=home" ] ++ btrfsFlags;
  };

  fileSystems."/var/lib" = {
    device = "/dev/disk/by-uuid/05417ab6-85c7-4466-8cf3-2d80e6b1e80e";
    fsType = "btrfs";
    options = [ "subvol=lib" ] ++ btrfsFlags;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/05417ab6-85c7-4466-8cf3-2d80e6b1e80e";
    fsType = "btrfs";
    options = [ "subvol=log" ] ++ btrfsFlags;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4C04-FC78";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."swap" = {
    device = "/dev/disk/by-uuid/b456c1e9-a281-4e19-b39d-9e7490bb5298";
    fsType = "btrfs";
    options = [ "subvol=swap noatime" ];
  };

  fileSystems."/mnt/media" = {
    device = "core:/media";
    fsType = "nfs";
  };

  swapDevices = [{ device = "/swap/swapfile"; }];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
