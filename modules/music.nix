{ ... }: {
  programs.ncmpcpp.enable = true;
  services.mpd = {
    enable = true;
    musicDirectory = "/mnt/media/music";
    playlistDirectory = "/mnt/media/music/playlists";
    extraConfig = ''
      playlist_plugin {
          name "m3u"
          enabled "true"
      }
      playlist_plugin {
          name "pls"
          enabled "true"
      }
      audio_output {
        type     "pipewire"
        name     "Local PipeWire Server"
        enabled  "yes"
      }
    '';
  };
}
