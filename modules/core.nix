{
  inputs,
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  zramSwap = {
    enable = true;
    memoryPercent = 25;
    priority = 5;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    configurationLimit = 15;
    device = "nodev";
    efiSupport = true;
    theme = pkgs.nixos-grub2-theme;
    default = "0";
  };
  boot.loader.timeout = 5;

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "zh_CN.UTF-8";
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-gtk
      qt6Packages.fcitx5-qt
      fcitx5-nord
    ];
  };
  i18n.inputMethod.fcitx5.waylandFrontend = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  services.libinput.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    tmux
    nixos-grub2-theme
    nix-output-monitor
    # sonobus
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    source-han-sans
    sarasa-gothic
    wqy_microhei
    wqy_zenhei
    noto-fonts-color-emoji
    fira-code
    nerd-fonts.jetbrains-mono
    maple-mono.NF-CN
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      # 先用拉丁字体，中文再回退到思源/苹方系，避免英文符号变宽
      monospace = [
        "JetBrainsMonoNL NF"
        "Maple Mono NF CN"
        "Noto Sans Mono"
        "Noto Sans Mono CJK SC"
        "Sarasa Mono SC"
      ];
      sansSerif = [
        "Noto Sans"
        "DejaVu Sans"
        "Source Han Sans SC"
        "Noto Sans CJK SC"
      ];
      serif = [
        "Noto Serif"
        "DejaVu Serif"
        "Source Han Serif SC"
      ];
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  system.stateVersion = "26.05";
}
