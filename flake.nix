{
  description = "Yuan's nixos config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    waybar = {
      url = "github:Alexays/Waybar/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    daeuniverse.url = "github:daeuniverse/flake.nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      waybar,
      chaotic,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      mkHost =
        {
          hostname,
          hostPath,
          homePath,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-unstable hostname; };
          modules = [
            hostPath
            chaotic.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs pkgs-unstable hostname; };
                users.yuan = import homePath;
                backupFileExtension = "bak";
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nixos = mkHost {
          hostname = "nixos";
          hostPath = ./host/desktop/configuration.nix;
          homePath = ./host/desktop/home.nix;
        };
        nixos-btw = mkHost {
          hostname = "nixos-btw";
          hostPath = ./host/mobile/configuration.nix;
          homePath = ./host/mobile/home.nix;
        };
      };
    };
}
