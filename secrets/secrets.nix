let
  keys = [
    # antharas
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINinNbduZJyQMg1+9cKB4EtlOZCw6bIEnBrRZy0HOufL"
    # zaken
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkTjhvrK3+r4xkkGxrQYKnpe+hsjtczcHuyDyzLWvC2"
    # work laptop (WSL)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3OFtgJAZjZ40MfcIBbKrqRrtOpXJGYbnjqFPgET28P"
  ];
in
{
  "openvpn-infillion.ovpn.age".publicKeys = keys;
  "aws-config.age".publicKeys = keys;
  "anthropic-key.age".publicKeys = keys;
}
