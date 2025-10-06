{
  inputs,
  system,
  secrets,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  lib = inputs.nixpkgs.lib;

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system inputs;
    config.allowUnfree = true;
  };

in {
  ymir = nixosSystem {
    inherit lib pkgs system;

    specialArgs = { inherit unstable-pkgs system secrets inputs; };

    modules = [
      ../system/configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.impermanence.nixosModules.impermanence
      {
        home-manager = {
          extraSpecialArgs = {inherit inputs secrets unstable-pkgs;};
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          users.jan = import ../home/home.nix;
        };
      }
      inputs.hyprland.nixosModules.default
      inputs.stylix.nixosModules.stylix
    ];
  };
}
