# NixOS and Home Manager configurations

You'll need a valid Nix installation. This repo defines a Nix shell, run `cmd` for a list of commands.

## Setup new NixOS machines
- Boot the NixOS ISO
- Prepare BTRFS partitions with a flat layout (see `machines/*/hardware-configuration.nix` and the [NixOS wiki](https://nixos.wiki/wiki/Btrfs)), mount under `/mnt`
- Run `nixos-generate-config --root /mnt` and make some adjustments if needed (network, GUI, ...)
- Run `nixos-install`
- Reboot and clone this repo, add a new folder under `machines/you-new-machine`, merge generated configs
- In the flake, add an entry to `nixosConfigurations` for the new machine
- Run `cmd rebuild`

## Setup new Linux machines via Home Manager
- Install Nix and make sure the daemon is running
- Enable Flake support in `/etc/nix/nix.conf`
- Clone this repo and run `nix develop`
- In the flake, add an entry to `homeConfigurations` for the new machine
- Run `cmd rebuild`
