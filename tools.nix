# Random helper functions
{
  # Reference a user secret that agenix will decrypt using the host key
  userSecret = fileName: {
    "${fileName}" = {
      file = secrets/${fileName}.age;
      owner = "kamek";
    };
  };

  # Define NixOS machines
  nixosMachine = system: nixpkgs: agenix: hm: user: hostName: {
    ${hostName} = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./machines/${hostName}/configuration.nix
        agenix.nixosModules.default
        hm.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./machines/${hostName}/home.nix;
        }
      ];
    };
  };
}
