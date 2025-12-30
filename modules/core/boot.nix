{ config,pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      theme = pkgs.nixos-grub2-theme;
      splashImage = "/home/cerydra/Pictures/WallPapers/wall2.png";
      default = "0";
      timeout = 3;
    };
    environment.systemPackages = [pkgs.nixos-grub2-theme ];
  # Kernel and bootloader
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Kernel parameters
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
