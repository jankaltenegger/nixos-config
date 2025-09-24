{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/jan/Music/";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };
}
