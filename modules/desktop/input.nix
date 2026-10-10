{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.input.enable = lib.mkEnableOption "Fcitx5, libinput and keyboard remapping";

  config = lib.mkIf config.my.input.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          qt6Packages.fcitx5-chinese-addons
          fcitx5-gtk
          qt6Packages.fcitx5-qt
          fcitx5-nord
        ];
      };
    };
    environment.sessionVariables = {
      QT_IM_MODULE = "fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
      XMODIFIERS = "@im=fcitx";
    };
    services.libinput.enable = true;
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings.main.capslock = "overload(control, esc)";
      };
    };
  };
}
