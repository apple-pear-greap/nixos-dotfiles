{ config, pkgs, ... }:

{
  # X11 and display server
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];

  # KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Keyboard configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Key remapping with keyd
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
          alt = {
            h = "left";
            l = "right";
            j = "down";
            k = "up";
          };
        };
      };
    };
  };
}
