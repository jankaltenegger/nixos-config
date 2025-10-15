{
  nixpkgs.overlays = [
    (import ./ripdrag.nix)
  ];
}
