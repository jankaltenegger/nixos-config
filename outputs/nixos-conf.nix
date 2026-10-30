{
  inputs,
  system,
  secrets,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

in {
  ymir = nixosSystem {
    specialArgs = {inherit unstable-pkgs system secrets inputs;};

    modules = [
      ../system/configuration.nix

      {
        nixpkgs = {
          hostPlatform = system;
          config = {
            allowUnfree = true;
            rocmSupport = true;
          };
          overlays = (import ../overlays).nixpkgs.overlays;
        };
      }

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
