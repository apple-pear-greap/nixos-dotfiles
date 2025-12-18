{ config, pkgs, ... }:

{
  # Auto-suspend configuration for laptop power management
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
    
    settings = {
      Login = {
        IdleAction = "suspend";
        IdleActionSec = "20min";
        HandlePowerKey = "poweroff";
        # If needed, we can adjust other inhibit-related timings here
        # InhibitDelayMaxSec = "5s";
      };
    };
  };

  # Ensure swaylock is installed for screen locking before suspend
  environment.systemPackages = with pkgs; [
    swaylock
  ];
}
