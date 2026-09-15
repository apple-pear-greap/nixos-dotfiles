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
	inputs.noctalia.homeModules.default
	inputs.mangobar.homeManagerModules.default
    ];
    services.mangobar = {
	enable = true;
	systemdTarget = "mango.target";
    };
    programs.noctalia = {
	enable = true;
    };

    programs.neovim = {
	enable = true;
	defaultEditor = true;
	vimAlias = true;
	viAlias = true;
    };
    programs.ghostty.enable = true;
    home.file.".config/nvim".source = ./config/nvim;
    home.stateVersion = "26.05";

    programs.bash = {
	enable = true;
	shellAliases = {
	    nrs = "sudo nixos-rebuild switch";
	};
    };



}
