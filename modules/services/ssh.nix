{ config, lib, ... }:
{
  options.my.ssh.enable = lib.mkEnableOption "OpenSSH with key-only authentication";

  config = lib.mkIf config.my.ssh.enable {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      openFirewall = true;
    };
  };
}
