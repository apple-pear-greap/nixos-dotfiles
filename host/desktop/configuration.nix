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
  ];

  my.input.enable = true;
  my.audio.enable = true;
  my.fonts.enable = true;
  my.bluetooth.enable = true;
  my.ssh.enable = true;
  my.graphics.nvidia.enable = true;
  my.gaming = {
    enable = true;
    performance.enable = true;
    aagl.enable = true;
  };

  my.x11.enable = false;
  my.wayland = {
    enable = true;
    wm = "niri";
  };

  # environment variables
  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/nvidia-dgpu:/dev/dri/intel-igpu";
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = false;
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
  };

  programs.kdeconnect.enable = true;

  my.power = {
    enable = true;
    profile = "performance";
  };
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 85;
  };

  services.tailscale.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yuan = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO//GYtVPFgC08ziOwn+8+ZwJqOcIwGkemNZJYFJjZ/a hysilens@csu.edu.cn"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGlpSnpK/ZKhqcGP3ibhlQjJI76udTF7bfiuupjp5P1F yoko64946@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDLsXLE5ZZrqx0p2GYU+oMQmMUfM1gs7e3IivkrwR9UW u0_a291@localhost"
    ];
  };

  system.stateVersion = "26.05";

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
