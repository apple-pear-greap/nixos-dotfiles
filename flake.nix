{
    description = "My Nixos's flake";
    nixConfig = {
      extra-substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store"];
    };
    inputs = {
      nixpkgs.url = "nixpkgs/nixos-25.11";
      daeuniverse.url = "github:daeuniverse/flake.nix";
      home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };   
      catppuccin.url = "github:catppuccin/nix";
      nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    };

    outputs = { self, nixpkgs, home-manager, catppuccin, nixos-hardware, ...}@inputs: {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       specialArgs = { inherit inputs; };
       modules = [
         nixos-hardware.nixosModules.common-cpu-intel
         nixos-hardware.nixosModules.common-pc-laptop
         nixos-hardware.nixosModules.common-pc-laptop-ssd
         ./configuration.nix
           inputs.daeuniverse.nixosModules.dae
           inputs.daeuniverse.nixosModules.daed

         home-manager.nixosModules.home-manager
         {
           home-manager = {
             useGlobalPkgs = true;
             useUserPackages = true;
             users.cerydra = {
		imports = [
		    ./home.nix
		    catppuccin.homeManagerModules.catppuccin
		];
	     };
             backupFileExtension = "bak";
          };
         }
      ];
    };
  };
}
