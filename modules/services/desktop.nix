{ ... }:

{
  # Display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # X11 support (optional, for compatibility)
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };

  # KDE Plasma Desktop Environment (can coexist with Niri)
  # services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;

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
