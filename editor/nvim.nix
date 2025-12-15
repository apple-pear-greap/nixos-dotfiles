  {config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      gcc
      gnumake
      cmake
      pkg-config

      nodejs
      python3

      lua-language-server
      nil

      stylua
      alejandra
      shfmt
      shellcheck

      fzf
      ripgrep
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink
./nvim;
    recursive = true;
  };

}
