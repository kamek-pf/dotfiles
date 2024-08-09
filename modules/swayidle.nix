{ pkgs, ... }:
let
  tools = import ../tools.nix { inherit pkgs; };
in
{
  services.swayidle = {
    enable = true;
    systemdTarget = "river-session.target";
    timeouts = [
      { timeout = 300; command = tools.cmd "swaylock" "-f"; }
    ];
  };
}
