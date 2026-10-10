{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.graphics.intel.enable = lib.mkEnableOption "Intel graphics";

  config = lib.mkIf config.my.graphics.intel.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
      ];
    };
  };
}
