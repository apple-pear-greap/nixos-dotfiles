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
    "tmux"
    "emacs"
  ];
in
{
  imports = [
    inputs.helium-flake.homeModules.default
    ../libs/xdg-links.nix
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

  programs.tmux.package = pkgs.tmux.overrideAttrs (old: {
    configureFlags = (old.configureFlags or [ ]) ++ [ "--enable-sixel" ];
  });

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      zc = "cd ~/nixos-config/";
      lg = "lazygit";
      ff = "fastfetch -c examples/13.jsonc";
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

  xdg.configFile = config.my.xdg.creatSymlinks configs;
}
