{ ... }:

{
  # Power management
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;
  services.upower.enable = true;
  powerManagement.powertop.enable = true;
  boot.kernelParams = [
    "quiet"
    "pcie_aspm=force"
  ];

  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";

      CPU_BOOST_ON_AC = "1";
      CPU_BOOST_ON_BAT = "0";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      START_CHARGE_THRESH_BAT0 = "80";
      STOP_CHARGE_THRESH_BAT0 = "90";
    };
  };

  # set hibernate and suspend
  boot.resumeDevice = "/dev/disk/by-uuid/e23a473f-f933-4123-be6d-f4b70ca56b8f";
  powerManagement.enable = true;
  services.logind.settings= {
      Login = {
          HandleLidSwitch = "suspend";
          HandlePowerKey = "hibernate";
        };
    };
  security.pam.services.swaylock = {};
    # use idle to set sleep auto

  # Storage optimization
  services.fstrim.enable = true;
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
}
