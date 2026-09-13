{
    description = "Yuan's nixos config";
    inputs = {
	nixpkgs.url = "nixpkgs/nixos-26.05";
	nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
	home-manager = {
	    url = "github:nix-community/home-manager/release-26.05";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
	mangowc = {
	    url = "github:mangowm/mango";
	    inputs.nixpkgs.follows = "nixpkgs-unstable";
	};
    };
    
    outputs = inputs @{ self, nixpkgs, nixpkgs-unstable, home-manager, mangowc, ... }: 
let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgs-unstable {
	inherit system;
	config.allowUnfree = true;
    };
in
{
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	    specialArgs = {inherit inputs pkgs-unstable; };
	    modules = [
		./configuration.nix
		mangowc.nixosModules.mango
		home-manager.nixosModules.home-manager
		{
		    home-manager = {
		        useGlobalPkgs = true;
			useUserPackages = true;
			extraSpecialArgs = { inherit inputs pkgs-unstable;};
			users.yuan = import ./home.nix;
		        backupFileExtension = "bak";
		    };
		}
	    ];
	};
    };
}
