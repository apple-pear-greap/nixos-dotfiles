{ config, pkgs, lib, ... }:

let
  flavor = "mocha"; # latte/frappe/macchiato/mocha
in
{
  home.packages = with pkgs; [
    # GTK theme
    catppuccin-gtk

    # icon + cursor (通用)
    papirus-icon-theme
    bibata-cursors
  ];

  # Wayland-only：不启用 x11 光标注入
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = false;

    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-${lib.strings.toUpper flavor}-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };
}