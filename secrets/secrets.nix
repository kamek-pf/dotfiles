# Remember to reference the age file in workstation.nix
let
  # Host keys
  system = {
    antharas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgBwOrzy1NNOSDJzEfpHIwZ3aN/kuN/7Cbh5E0sRpxy";
    zaken = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDy4DI5twJvO6kMWeS9kqWcfrw87U+OHLr0MzFkehErS";
  };

  # User keys
  home = {
    antharas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINinNbduZJyQMg1+9cKB4EtlOZCw6bIEnBrRZy0HOufL";
    zaken = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkTjhvrK3+r4xkkGxrQYKnpe+hsjtczcHuyDyzLWvC2";
  };

  workstations = [
    system.antharas
    system.zaken
    home.antharas
    home.zaken
  ];
in
{
  "openvpn-infillion.ovpn.age".publicKeys = workstations;
  "aws-config.age".publicKeys = workstations;
  "anthropic-key.age".publicKeys = workstations;
}
