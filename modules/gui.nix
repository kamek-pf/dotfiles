{ ... }: {
  # Import GUI applications requiring config, those won't work outside of NixOS
  # without the NixGL workaround.
  imports = [
    ./alacritty.nix
  ];
}
