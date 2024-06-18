@_default:
	just --list --unsorted

# Login on services that require it.
login:
	sudo tailscale login
	atuin login

# NixOS update: update flake and rebuild
update: && rebuild
	nix flake update
	
# Generate configuration files (NixOS)
rebuild:
	sudo nixos-rebuild switch --flake .

# Cleanup old generations, only retain the last 3 days
cleanup:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
	sudo nix store gc
		
# Only needed once per non-NixOS machine, symlinks configs where needed
init-home-manager:
	mkdir -p $HOME/.config/home-manager
	unlink $HOME/.config/home-manager/flake.nix
	ln -s $PWD/flake.nix $HOME/.config/home-manager

# Generate configuration files (Home Manager)
rebuild-home-manager:
	home-manager switch -b backup
