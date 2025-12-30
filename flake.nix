{
  description = "My Nixos's flake";
  nixConfig = {
    extra-substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  };
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    # expose an unstable channel so specific newer packages can be used
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
        url = "github:DreamMaoMao/mangowc";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      }; 
    dms = {
        url = "github:AvengeMedia/DankMaterialShell";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      }; 
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    daeuniverse.url = "github:daeuniverse/flake.nix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixvim,
      mango,
      dms,
      ...
    }@inputs:
    let
      mkNixosConfig =
        {
          hostname,
          modules ? [],
        }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            unstable = inputs.nixpkgs-unstable.legacyPackages."x86_64-linux";
          };
          modules = [
            ./hosts/${hostname}/configuration.nix
            mango.nixosModules.mango
            {
                programs.mango.enable = true;
              }
            inputs.daeuniverse.nixosModules.dae
            inputs.daeuniverse.nixosModules.daed
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
		extraSpecialArgs = { inherit inputs; };
                users.cerydra = {
                  imports = [
                  inputs.dms.homeModules.dankMaterialShell.default
                    ./home.nix
		    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
                backupFileExtension = "bak";
              };
            }
          ]
          ++ modules;
        };
    in
    {
      nixosConfigurations = {
        nixos = mkNixosConfig {
          hostname = "nixos";
          modules = [
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-pc-laptop-ssd
          ];
        };

        # Template for second machine - customize as needed
        # machine2 = mkNixosConfig {
        #   hostname = "machine2";
        #   modules = [
        #     # Add appropriate nixos-hardware modules for your second machine
        #   ];
        # };
      };
    };
}
