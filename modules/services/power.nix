{ config, pkgs, ... }:

{
  # Auto-suspend configuration for laptop power management
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    
    settings = {
      Login = {
        IdleAction = "suspend";
        IdleActionSec = "20min";
        HandlePowerKey = "poweroff";
      };
    };
  };

  # Ensure swaylock is installed for screen locking before suspend
  environment.systemPackages = with pkgs; [
    swaylock
  ];
}
