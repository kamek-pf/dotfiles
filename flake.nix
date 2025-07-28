{
  description = "Kamek's Nix config files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, agenix, ... }:
    let
      system = "x86_64-linux";
      user = "kamek";
      pkgs = import nixpkgs { inherit system; };
      tools = import ./tools.nix { inherit pkgs; };
      # Pass a hostname to define new NixOS machines
      nixosMachine = tools.nixosMachine system nixpkgs agenix home-manager user;
      # Pass a state version and settings record to define Home Manager configs
      linuxMachine = tools.homeManagerConfig home-manager;

    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          tools.mainCli
          pkgs.home-manager # Still need `pkgs` here to avoid ambiguous name
          agenix.packages.${system}.default
          age
          ripgrep
          nix
          nil
          nixpkgs-fmt
          nushell
          helix
        ];
      };

      # NixOS machines
      nixosConfigurations =
        nixosMachine "antharas" //
        nixosMachine "zaken";

      # Linux / WSL machines
      homeConfigurations = linuxMachine "25.11" {
        username = "kamek_havenstudios";
        git = {
          username = "kamek_sie";
          email = "kamek@havenstudios.com";
        };
      };
    };
}
