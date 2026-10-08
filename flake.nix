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
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    daeuniverse = {
      url = "github:daeuniverse/flake.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
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
          extraModules ? [ ],
        }:
        let
          specialArgs = { inherit inputs pkgs-unstable hostname; };
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            hostPath
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
                users.yuan = import homePath;
                backupFileExtension = "bak";
              };
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        nixos = mkHost {
          hostname = "nixos";
          hostPath = ./host/desktop/configuration.nix;
          homePath = ./host/desktop/home.nix;
          extraModules = [ chaotic.nixosModules.default ];
        };
        nixos-btw = mkHost {
          hostname = "nixos-btw";
          hostPath = ./host/mobile/configuration.nix;
          homePath = ./host/mobile/home.nix;
        };
      };
    };
}
