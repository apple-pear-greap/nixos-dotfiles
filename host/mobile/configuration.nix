{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/core.nix
    inputs.daeuniverse.nixosModules.dae
  ];

  my.input.enable = true;
  my.audio.enable = true;
  my.fonts.enable = true;
  my.bluetooth.enable = true;
  my.ssh.enable = true;
  my.graphics.intel.enable = true;
  my.gaming.enable = true;

  my.x11 = {
    enable = true;
    wm = "dwm";
  };
  my.wayland.enable = false;

  zramSwap.enable = true;

  #use a systemd service to unblock bluetooth
  systemd.services.unblock-bluetooth = {
    description = "Unblock Bluetooth on boot";
    wantedBy = [ "bluetooth.service" ];
    before = [ "bluetooth.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.util-linux}/bin/rfkill unblock bluetooth";
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Enable the X11 windowing system.

  my.power = {
    enable = true;
    profile = "powersave";
  };
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 70;
    STOP_CHARGE_THRESH_BAT0 = 95;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  services.dae = {
    enable = true;

    openFirewall = {
      enable = true;
      port = 12345;
    };

    configFile = "/home/yuan/.proxy.dae";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "26.05"; # Did you read the comment?

}
