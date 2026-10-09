{
  inputs,
  pkgs,
  config,
  pkgs-unstable,
  ...
}:
let
  configs = [
    "nvim"
    "rofi"
    "foot"
    "emacs"
  ];
in
{
  imports = [
    inputs.helium-flake.homeModules.default
    inputs.agenix.homeManagerModules.default
    ../libs/xdg-links.nix
    ./x11.nix
    ./wayland.nix
    ./ai.nix
    ./latex.nix
    ./librewolf.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    # cli tools
    jq
    lazygit
    bat
    ffmpegthumbnailer
    glow
    chafa
    ffmpeg
    sxiv

    # cli toys
    brightnessctl
    fastfetch
    pkgs-unstable.fetch
    tree
    btop

    #gui tools
    kdePackages.okular
    # volumn control and bluetooth
    pamixer
    pavucontrol
    pulsemixer
    bluetui

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

  age.secrets.apikey = {
    file = ../secrets/secret_ds.age;
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
      texlab

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

  programs.nnn = {
    enable = true;
    package = pkgs-unstable.nnn.override { withNerdIcons = true; };
    plugins = {
      src =
        (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v5.2";
          sha256 = "sha256-u+88aDHfOZ6bSkg6ahS6eNZWj2QCwJXKW+8nHR99kic=";
        })
        + "/plugins";
      mappings = {
        p = "preview-tui";
      };
    };

    enableBashIntegration = true;
    quitcd = true;
  };

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--enable-features=AcceleratedVideoDecodeLinuxGL"
    ];
  };

  xdg.configFile = config.my.xdg.creatSymlinks configs;
}
