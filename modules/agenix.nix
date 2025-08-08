{ settings, ... }: {
  age = {
    identityPaths = [ "/home/${settings.username}/.ssh/id_ed25519" ];
    secrets = {
      anthropic-key.file = ../secrets/anthropic-key.age;
      aws-config.file = ../secrets/aws-config.age;
      "openvpn-infillion.ovpn.age".file = ../secrets/openvpn-infillion.ovpn.age;
    };
  };
}
