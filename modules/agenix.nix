{ settings, ... }:
let
  secretsFile = import ../secrets/secrets.nix;
  # Can you split on ".age" and take the left part AI!
  secretNames = builtins.map
    (name: builtins.substring 0 (builtins.stringLength name - 4) name)
    (builtins.attrNames secretsFile);

  makeSecrets = builtins.foldl' doMerge { };
  doMerge = acc: fileName: acc // {
    "${fileName}".file = ../secrets/${fileName}.age;
  };
in
{
  age = {
    identityPaths = [ "/home/${settings.username}/.ssh/id_ed25519" ];
    secrets = makeSecrets secretNames;
  };
}
