{ config, lib, ... }:
{
  options.my.bluetooth.enable = lib.mkEnableOption "Bluetooth support";

  config = lib.mkIf config.my.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}
