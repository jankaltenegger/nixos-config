{ unstable-pkgs, ... }:
{
  programs.rmpc = {
    enable = true;
    package = unstable-pkgs.rmpc;
    config = ''
      (
        album_art: (
          method: Auto
        )
      )
    '';
  };
}
