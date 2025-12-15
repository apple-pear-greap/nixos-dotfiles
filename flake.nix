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
    };

    outputs = { self, nixpkgs, home-manager, ...}@inputs: {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [
         ./configuration.nix
           inputs.daeuniverse.nixosModules.dae
           inputs.daeuniverse.nixosModules.daed

         home-manager.nixosModules.home-manager
         {
           home-manager = {
             useGlobalPkgs = true;
             useUserPackages = true;
             users.cerydra = import ./home.nix;
             backupFileExtension = "backup";
          };
         }
      ];
    };
  };
}
