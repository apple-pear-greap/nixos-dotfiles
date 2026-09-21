{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
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
  };
in
{
  imports = [
    ../../home-modules/yazi.nix
    inputs.helium-flake.homeModules.default
  ];
  home.username = "yuan";
  home.homeDirectory = "/home/yuan";
  home.packages = with pkgs; [
    jq
    fastfetch
    tree
    rofi
    adwaita-icon-theme
    btop
    pavucontrol
    lazygit
    pamixer
    gamescope
    bluetui
    spotify

    foot
    swaybg
    waybar

    pkg-config
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    font = {
      name = "JetBrainsMonoNL NFP";
      size = 14;
    };
    settings = {
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.3";
      cursor_trail_start_threshold = 3;

      background_opacity = 0.8;
    };
  };

  programs.firefox.enable = true;
  programs.chromium = {
    enable = true;
  };
  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];
  };
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

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = creatSymlink "${configPath}/${subpath}";
    recursive = true;
  }) configs;

  home.stateVersion = "26.05";
}
