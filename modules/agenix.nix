{ settings, ... }:
let
  makeSecrets = builtins.foldl' doMerge { };
  doMerge = acc: fileName: acc // {
    "${fileName}".file = ../secrets/${fileName}.age;
  };
in
{
  age = {
    identityPaths = [ "/home/${settings.username}/.ssh/id_ed25519" ];
    # I like this, but I'd like to get those values from the secrets.nix file AI!
    secrets = makeSecrets [
      "anthropic-key"
      "aws-config"
      "openvpn-infillion.ovpn"
    ];
  };
}
