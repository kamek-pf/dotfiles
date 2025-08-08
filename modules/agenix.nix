{ settings, ... }:
let
  secretsFile = import ../secrets/secrets.nix;
  secretNames = builtins.map
    (name: builtins.elemAt (builtins.split "\\.age" name) 0)
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
