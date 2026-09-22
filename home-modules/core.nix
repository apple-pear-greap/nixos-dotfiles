{
  inputs,
  pkgs,
  config,
  ...
}:
let
  configPath = "${config.home.homeDirectory}/nixos-config/config";
  creatSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    rofi = "rofi";
    foot = "foot";
    sway = "sway";
    hypr = "hypr";
    mango = "mango";
    tmux = "tmux";
    emacs = "emacs";
  };
in
{
  imports = [
    ./yazi.nix
    inputs.helium-flake.homeModules.default
  ];
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Cerydra";
      user.email = "cerydrahysilens@qq.com";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      zc = "cd ~/nixos-config/";
    };
  };

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

      nixpkgs-fmt

      gcc
      clang
    ];
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = creatSymlink "${configPath}/${subpath}";
    recursive = true;
  }) configs;
}
