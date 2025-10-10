{
  inputs,
  system,
  secrets,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  lib = inputs.nixpkgs.lib;

  overlays = (import ../overlays).nixpkgs.overlays;
  pkgs = import inputs.nixpkgs {
    inherit system overlays;
    config.allowUnfree = true;
  };

  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system inputs;
    config.allowUnfree = true;
  };
in {
  ymir = nixosSystem {
    inherit lib pkgs system;

    specialArgs = {inherit unstable-pkgs system secrets inputs;};

    modules = [
      ../system/configuration.nix

      inputs.impermanence.nixosModules.impermanence
      inputs.home-manager.nixosModules.home-manager
      inputs.hyprland.nixosModules.default
      inputs.stylix.nixosModules.stylix

      {
        home-manager = {
          extraSpecialArgs = {inherit inputs secrets unstable-pkgs;};
          useGlobalPkgs = true;
          useUserPackages = true;
          users.jan = import ../home/home.nix;

          sharedModules = [
            {
              stylix.targets = {
                starship.enable = false;
                nixvim.enable = false;
              };
            }
          ];
        };
      }
    ];
  };
}
