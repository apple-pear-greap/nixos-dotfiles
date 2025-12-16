{ config, pkgs, ...}:
{
    programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      gs = "git status";
      nrs = "sudo nixos-rebuild switch";
      cat = "bat";
    };

    initContent = ''

      autoload -Uz compinit
      compinit -u
   
    '';
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # enableFishIntegration = true;
  };
  programs.fish = {
    enable = false;
    interactiveShellInit = ''
	set fish_greeting
    '';
    plugins = [
	# { name = "grc"; src = pkgs.fishPlugins.grc.src; }
	{ name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
	# { name = "plugin-git"; src = pkgs.fishPlugins.plugin-git.src;}
	# { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
    ];
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      gs = "git status";
      nrs = "sudo nixos-rebuild switch";
      cat = "bat";
      rm = "rm -i";
      cp = "cp -i";
    };
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  home.packages = with pkgs; [
    ripgrep
    fzf
    fd
    jq
    yazi
  ];
  xdg.configFile."starship.toml".source = ./starship.toml;
}
