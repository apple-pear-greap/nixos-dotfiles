{ config, ... }:
{
  age.secrets.apikey = {
    file = ../../secrets/secret_ds.age;
    mode = "0400";
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      zc = "cd ~/nixos-config/";
      lg = "lazygit";
      ff = "fastfetch -c examples/13.jsonc";
    };
    initExtra = ''
      export DEEPSEEK_API_KEY=$(cat ${config.age.secrets.apikey.path})
    '';
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    presets = [ "pure-preset" ];
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
}
