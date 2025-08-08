{ settings, ... }:
let
  # Read secrets names from the source record
  # This turns `{"something.age": ...}` into `["something"]`
  secretsFile = import ../secrets/secrets.nix;
  readName = name: builtins.substring 0 (builtins.stringLength name - 4) name;
  secretNames = map readName (builtins.attrNames secretsFile);

  # Build the record expected bye agenix
  # This generates `{"something".file: ../secrets/something.age;}` 
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
