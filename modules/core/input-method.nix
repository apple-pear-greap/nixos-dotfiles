{ config, pkgs, ... }:

{
  # Input method configuration
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt   # Qt5
      qt6Packages.fcitx5-qt  # Qt6
      qt6Packages.fcitx5-chinese-addons
      fcitx5-nord
    ];
  };

  # Ensure toolkits see fcitx5 (helps WPS/Qt/GTK input)
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "fcitx";
  };
}
