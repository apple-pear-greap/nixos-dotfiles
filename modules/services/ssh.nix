{ config, pkgs, ... }:

{
  # Enable OpenSSH daemon for remote access
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;  # Set to false after adding your keys for better security
      PubkeyAuthentication = true;
    };
  };

  # Open SSH port in firewall
  networking.firewall.allowedTCPPorts = [ 22 ];
}
