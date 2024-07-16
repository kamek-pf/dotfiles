# This module includes shell scripts that should be globally accessible.
# Derivations should be included in package lists.
{ pkgs, ... }: {
  twitch =
    let
      streamlink = "${pkgs.streamlink}/bin/streamlink";
      mpv = "${pkgs.mpv}/bin/mpv";
    in
    pkgs.writeShellScriptBin "ttv" ''
      ${streamlink} --player ${mpv} twitch.tv/$1 best
    '';
}
