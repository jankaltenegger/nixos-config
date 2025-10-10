final: prev: {
  zellij = prev.zellij.overrideAttrs (old: let
    sixelImageSrc = prev.fetchFromGitHub {
      owner = "jankaltenegger";
      repo = "sixel-image";
      rev = "c39d1aa9beec8ed16ad16efdb83f97c1477e0660";
      hash = "sha256-LogHnfINS75ZtEScdG4QxuPXr3sLOLESG8LrxwdMLaE=";
    };

    sixelCratePath = "${sixelImageSrc}";
  in {
    postPatch = (old.postPatch or "") + ''
      target="$cargoDepsCopy/vendor/sixel-image-0.1.0"

      chmod -R u+rwX "$cargoDepsCopy/venodr" || true

      rm -rf "$target"
      mkdir -p "$target"
      cp -R "${sixelCratePath}/." "$target"/
    '';
  });
}
