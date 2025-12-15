{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  # daed for network
  services.daed = {
    enable = true;
    listen = "0.0.0.0:2023";
    openFirewall = {
      enable = true;
      port = 12345;
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # fonts
  fonts.packages = with pkgs;[
	noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-cjk-serif
	noto-fonts-color-emoji
	sarasa-gothic
	jetbrains-mono
  ];
  fonts.fontconfig = {
	enable = true;
	defaultFonts = {
	    emoji = ["Noto Color Emoji"];
	    monospace = ["Noto Sans Mono CJK SC" "Sarasa Mono SC" "DejaVu Sans Mono"];
	    sansSerif = ["Noto Sans CJK SC" "Source Han Serif SC" "DejaVu Serif"];
	    serif = ["Noto Serif CJK SC" "Source Han Serif SC" "DejaVu Serif"];
  	};
  };

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
  # Fcitx5
  i18n.inputMethod = {
	type = "fcitx5";
	enable = true;
	fcitx5.waylandFrontend = true;
	fcitx5.addons = with pkgs;[
	    fcitx5-gtk
	    qt6Packages.fcitx5-chinese-addons
	    fcitx5-nord
	];
  };

  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Config keyd for key map
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
          alt = {
            h = "left";
            l = "right";
            j = "down";
            k = "up";
          };
        };
      };
    };
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cerydra = {
    isNormalUser = true;
    description = "Cerydra";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
       fastfetch
       alacritty
       splayer
       localsend
       wpsoffice-cn
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    curl
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

    nix.settings = {
     experimental-features = [ "nix-command" "flakes"];
     substituters = ["https://mirrors.ustc.edu.cn/nix-channels/store"];
  };
  system.stateVersion = "25.11"; # Did you read the comment?

}
