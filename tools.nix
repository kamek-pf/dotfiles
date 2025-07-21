# Random helper functions
{ pkgs, ... }: {
  # Execute a command by referencing its Nix path and set arguments
  cmd = bin: args: "${pkgs.${bin}}/bin/${bin} ${args}";

  # Provides the "cmd" entrypoint
  mainCli = with pkgs; writeShellScriptBin "cmd" ''
    ${nushell}/bin/nu ./scripts/cmd "$@"
  '';

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
          home-manager.users.${user} = import ./machines/${hostName}/home.nix { inherit user; };
        }
      ];
    };
  };

  # Define standalone HomeManager configurations, for non-NixOS machines
  homeManagerConfig = hm: username: stateVersion: {
    ${username} = hm.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./modules/common.nix
        {
          home = {
            inherit stateVersion username;
            homeDirectory = "/home/${username}";
          };
        }
      ];
    };
  };
}
