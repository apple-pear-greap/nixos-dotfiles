{ config, pkgs, unstable, ... }:

{
  # Enable Niri window manager
  programs.niri.enable = true;

  # Display manager configuration for Niri
  services.displayManager.sessionPackages = [ pkgs.niri ];
  
  # Essential packages for Niri
  environment.systemPackages = with pkgs; [
    niri
    # Application launcher
    fuzzel
    # Notification daemon
    mako
    # Status bar
    waybar
    # Screenshot tool
    grim
    slurp
    # Clipboard manager
    wl-clipboard
    # Screen locker
    swaylock
    # Wallpaper
    swaybg
    # File manager
    xfce.thunar
    # Network management
    networkmanagerapplet
    # Bluetooth management
    blueman
    # Audio control
    pavucontrol
    # xwayland support - use unstable package to fix WeChat right-click menu
    unstable.xwayland-satellite
  ];

  # XDG portal for screen sharing and other desktop integration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # Enable polkit for privilege escalation
  security.polkit.enable = true;
}
