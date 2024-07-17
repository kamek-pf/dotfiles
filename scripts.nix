# This module includes shell scripts that should be globally accessible.
# Derivations should be included in package lists.
{ pkgs, ... }: {
  twitch = pkgs.writeShellScriptBin "ttv" ''
    streamlink --player mpv twitch.tv/$1 best
  '';

  record-start = pkgs.writeShellScriptBin "record-start" ''
    BASEPATH="/tmp/capture"
    FILEPATH="$BASEPATH/$(uuidgen).mp4"
    BINDING_HINT="Hit <i>Super+Shift+Print</i> to stop screen capture"
    COPY_HINT="Output path was copied to clipboard"
    mkdir -p $BASEPATH
    notify-send "Recording" "$BINDING_HINT\n$COPY_HINT"
    wl-copy $FILEPATH
    wf-recorder -g "$(slurp)" -f $FILEPATH
  '';

  record-stop = pkgs.writeShellScriptBin "record-stop" ''
    kill -s INT $(pidof wf-recorder)
    notify-send "Stopped recording" "The file path is in your clipboard"
  '';
}
