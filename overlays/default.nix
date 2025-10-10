{
  nixpkgs.overlays = [
    (import ./zellij-sixel.nix)
    (import ./ripdrag.nix)
  ];
}
