{
  inputs,
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/nvidia.nix
    inputs.aagl.nixosModules.default
  ];

  my.x11.enable = false;
  my.wayland = {
    enable = true;
    wm = "niri";
  };

  # environment variables
  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/nvidia-dgpu:/dev/dri/intel-igpu";
    LIBVA_DRIVER_NAME = "iHD";
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
    XMODIFIERS = "@im=fcitx";
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = false;
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
  };

  programs.kdeconnect.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 85;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      PLATFORM_PROFILE_ON_AC = "performance";
    };
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      pkgs-unstable.dwproton-bin
      pkgs-unstable.proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;

  # 配置 Cachix，避免自行编译启动器
  nix.settings = inputs.aagl.nixConfig;

  # 启用你需要的启动器
  programs.anime-game-launcher.enable = true;
  programs.honkers-railway-launcher.enable = true;
  programs.sleepy-launcher.enable = true;

  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks
  ];

  services.tailscale.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yuan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO//GYtVPFgC08ziOwn+8+ZwJqOcIwGkemNZJYFJjZ/a hysilens@csu.edu.cn"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGlpSnpK/ZKhqcGP3ibhlQjJI76udTF7bfiuupjp5P1F yoko64946@gmail.com"
    ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).

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

}
