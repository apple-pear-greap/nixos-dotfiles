{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nil
      clang-tools
      lua-language-server
      texlab
      nixpkgs-fmt
      gcc
      clang
    ];
  };
  xdg.configFile.nvim = config.my.xdg.creatSymlink "nvim";
}
