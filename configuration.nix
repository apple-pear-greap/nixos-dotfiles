{ inputs, config, lib, pkgs, pkgs-unstable, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
    ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  zramSwap.enable = true;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

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

  # environment variables
  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/intel-igpu:/dev/dri/nvidia-dgpu";
    LIBVA_DRIVER_NAME = "iHD";
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
    XMODIFIERS = "@im=fcitx";
  };

  networking.hostName = "nixos"; # Define your hostname.
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
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
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
          main = { capslock = "overload(control, esc)"; };
        };
      };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
  };

  programs.kdeconnect.enable = true;

  # 禁用 KDE 默认的 power-profiles-daemon
  services.power-profiles-daemon.enable = false;
  # 启用并配置 TLP
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 85;

      # --- 交流电 (AC) 性能优化 ---
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      PLATFORM_PROFILE_ON_AC = "performance";
    };
  };

  nixpkgs.config.allowUnfree = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs;[
      pkgs-unstable.dwproton-bin
      pkgs-unstable.proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;


  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yuan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO//GYtVPFgC08ziOwn+8+ZwJqOcIwGkemNZJYFJjZ/a hysilens@csu.edu.cn"
    ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
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
      monospace = [ "JetBrainsMonoNL NF" "Maple Mono NF CN" "Noto Sans Mono" "Noto Sans Mono CJK SC" "Sarasa Mono SC" ];
      sansSerif = [ "Noto Sans" "DejaVu Sans" "Source Han Sans SC" "Noto Sans CJK SC" ];
      serif = [ "Noto Serif" "DejaVu Serif" "Source Han Serif SC" ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "26.05";

}

