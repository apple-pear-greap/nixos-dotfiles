{ inputs, config, pkgs, pkgs-unstable, ... }:

{
    home.username = "yuan";
    home.homeDirectory = "/home/yuan";
    programs.git = {
    enable = true;
    settings = {
	  user.name = "Cerydra";
	  user.email = "cerydrahysilens@qq.com";
	};
    };
    imports = [
	inputs.mangobar.homeManagerModules.default
    ];
    services.mangobar = {
	enable = true;
	systemdTarget = "mango.target";
    };

    xdg.configFile."nvim" = {
    	source = config.lib.file.mkOutOfStoreSymlink "/home/yuan/nixos-config/config/nvim/";
	recursive = true;
    };

    programs.ghostty.enable = true;
    home.stateVersion = "26.05";

    programs.bash = {
	enable = true;
	shellAliases = {
	    nrs = "sudo nixos-rebuild switch";
	};
    };



}
