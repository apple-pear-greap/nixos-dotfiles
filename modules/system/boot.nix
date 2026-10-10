{ pkgs, ... }:
{
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
}
