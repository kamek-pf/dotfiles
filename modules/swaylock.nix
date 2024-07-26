{ ... }:
let colors = import ./colors.nix;
in {
  programs.swaylock = {
    enable = true;
    settings = with colors.varua; {
      image = "~/Dev/dotfiles/wallpapers/sea_locked.jpg";
      indicator-radius = 75;
      key-hl-color = normal.blue;
      inside-color = normal.blue;
      inside-clear-color = normal.yellow;
      inside-ver-color = normal.white;
      inside-wrong-color = normal.red;
      ring-color = normal.blue;
      ring-clear-color = bright.yellow;
      ring-ver-color = bright.white;
      ring-wrong-color = bright.red;
    };
  };
}
