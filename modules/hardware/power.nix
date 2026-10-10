{ config, lib, ... }:
let
  cfg = config.my.power;
in
{
  options.my.power.enable = lib.mkEnableOption "TLP power management";
  options.my.power.profile = lib.mkOption {
    default = "powersave";
    type = lib.types.enum [
      "performance"
      "powersave"
    ];
    description = "Power policy: AC performance or battery-first power saving.";
  };

  config = lib.mkIf cfg.enable {
    powerManagement.enable = true;
    services.power-profiles-daemon.enable = false;
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = lib.mkDefault "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = lib.mkDefault "performance";
        CPU_MIN_PERF_ON_AC = lib.mkDefault 0;
        CPU_MAX_PERF_ON_AC = lib.mkDefault 100;
      }
      // lib.optionalAttrs (cfg.profile == "performance") {
        CPU_BOOST_ON_AC = lib.mkDefault 1;
        CPU_HWP_DYN_BOOST_ON_AC = lib.mkDefault 1;
        PLATFORM_PROFILE_ON_AC = lib.mkDefault "performance";
      }
      // lib.optionalAttrs (cfg.profile == "powersave") {
        CPU_SCALING_GOVERNOR_ON_BAT = lib.mkDefault "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = lib.mkDefault "power";
        CPU_MIN_PERF_ON_BAT = lib.mkDefault 0;
        CPU_MAX_PERF_ON_BAT = lib.mkDefault 20;
        CPU_BOOST_ON_BAT = lib.mkDefault 0;
        CPU_HWP_DYN_BOOST_ON_BAT = lib.mkDefault 0;
        PLATFORM_PROFILE_ON_BAT = lib.mkDefault "low-power";
      };
    };
  };
}
