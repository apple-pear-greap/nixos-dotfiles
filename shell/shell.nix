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
  };
  home.packages = with pkgs; [
  ];
  xdg.configFile."starship.toml".source = ./starship.toml;
}
