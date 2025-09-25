{
  description = "Jan's lil flake";

  inputs = {
    # Impermanence
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # Nix Packages Repo
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.48.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Zen Browser
    zen-browser.url = "github:youwen5/zen-browser-flake";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
    };

    # NixVim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs:
    with inputs; let
      system = "x86_64-linux";
      #    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
    in {
      nixosConfigurations =
        import ./outputs/nixos-conf.nix {inherit inputs secrets system;};
    };
}
