# Random helper functions
{ pkgs, ... }:
let defaultSettings = import ./settings.nix;
in {
  # Execute a command by referencing its Nix path and set arguments
  cmd = bin: args: "${pkgs.${bin}}/bin/${bin} ${args}";

  # Provides the `cmd` entrypoint
  mainCli = with pkgs; writeShellScriptBin "cmd" ''
    ${nushell}/bin/nu ./scripts/cmd "$@"
  '';

  # Reference a user secret that agenix will decrypt using the host key
  userSecret = fileName: {
    "${fileName}" = {
      file = secrets/${fileName}.age;
      owner = defaultSettings.username;
    };
  };

  # Define NixOS machines
  nixosMachine = system: nixpkgs: agenix: hm: machineSettings: hostName:
    let
      # Merge settings
      settings = pkgs.lib.recursiveUpdate defaultSettings machineSettings;
      user = settings.username;
      # Define Home Manager module settings
      homeManagerSettings = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ./machines/${hostName}/home.nix { inherit user; };
        home-manager.extraSpecialArgs = { inherit settings; };
      };
      # Define list of modules
      modules = [
        ./machines/${hostName}/configuration.nix
        agenix.nixosModules.default
        hm.nixosModules.home-manager
        homeManagerSettings
      ];
    in
    {
      ${hostName} = nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = {
          inherit settings;
        };
      };
    };

  # Define standalone HomeManager configurations, for non-NixOS machines
  homeManagerConfig = hm: stateVersion: machineSettings:
    let
      # Merge settings
      settings = pkgs.lib.recursiveUpdate defaultSettings machineSettings;
      # Define Home Manager module
      homeModule = {
        inherit stateVersion;
        username = settings.username;
        homeDirectory = "/home/${settings.username}";
      };
      # Define list of modules
      modules = [
        { home = homeModule; }
        ./modules/common.nix
      ];
    in
    {
      ${settings.username} = hm.lib.homeManagerConfiguration {
        inherit pkgs modules;
        extraSpecialArgs = {
          inherit settings;
        };
      };
    };
}
