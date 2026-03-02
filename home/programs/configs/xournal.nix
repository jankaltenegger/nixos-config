{ pkgs, ... }:

let
  # This keeps your INI content tucked away in a variable
  myTemplates = ''
    [nordDotted]
    name=Nord-themed dotted graph paper
    format=dotted
    config=f1=#4c566a
  '';
in
{
  xdg.dataFile."xournalpp/ui/pagetemplates.ini".text = myTemplates;

  home.packages = [
    (pkgs.symlinkJoin {
      name = "xournalpp-wrapped";
      paths = [ pkgs.xournalpp ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/xournalpp \
          --set XOURNALPP_DATA_DIR "$HOME/.local/share/xournalpp"
      '';
    })
  ];
}
