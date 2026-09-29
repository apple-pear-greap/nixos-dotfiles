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
    waybar = "waybar";
  };
in
{
  imports = [
    ./yazi.nix
    inputs.helium-flake.homeModules.default
  ];

  home.packages = with pkgs; [
    # cli tools
    jq
    lazygit

    # cli toys
    fastfetch
    tree
    btop

    # wallpapers
    swaybg

    # terminal
    foot
    kitty

    # app launchaer
    rofi

    # clip
    wl-clipboard
    cliphist

    # screen shot
    grim
    slurp

    # volumn control and bluetooth
    pamixer
    pavucontrol
    pulsemixer
    bluetui
    blueman

    #CN must have
    wechat

    #lsp
    nixd
    nixfmt
    clang-tools
    lua-language-server

    #program tools
    clang
    gnumake
    cmake
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.firefox.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      zc = "cd ~/nixos-config/";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    presets = [ "pure-preset" ];
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Cerydra";
      user.email = "cerydrahysilens@qq.com";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
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
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.nixfmt
    ];
  };

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];
  };

  programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = creatSymlink "${configPath}/${subpath}";
    recursive = true;
  }) configs;
}
