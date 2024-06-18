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
      # Define NixOS machines
      nixosMachine = hostName: {
        ${hostName} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/${hostName}/configuration.nix
            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = import ./machines/${hostName}/home.nix;
            }
          ];
        };
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          pkgs.home-manager # Still need pkgs here to avoid ambiguous name
          agenix.packages.${system}.default
          age
          ripgrep
          just
        ];
      };

      nixosConfigurations =
        nixosMachine "antharas" //
        nixosMachine "zaken";
    };
}
