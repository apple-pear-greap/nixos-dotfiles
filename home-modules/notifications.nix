{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.libnotify ];

  services.mako = lib.mkIf config.my.hm.wayland.enable {
    enable = true;
    settings = {
      anchor = "top-right";
      font = "Maple Mono NF CN 12";
      default-timeout = 5000;
      max-visible = 5;
      background-color = "#282a36ee";
      text-color = "#f8f8f2";
      border-color = "#bd93f9";
      border-size = 2;
      border-radius = 8;
      "urgency=critical".default-timeout = 0;
    };
  };

  # Mako requires Wayland; use Dunst for the mobile's X11/DWM session.
  services.dunst = lib.mkIf (config.my.hm.x11.enable && !config.my.hm.wayland.enable) {
    enable = true;
    settings.global = {
      font = "Maple Mono NF CN 12";
      origin = "top-right";
      timeout = 5;
      background = "#282a36";
      foreground = "#f8f8f2";
      frame_color = "#bd93f9";
    };
  };
}
