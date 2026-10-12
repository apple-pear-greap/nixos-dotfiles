{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  icatMini = pkgs.stdenvNoCC.mkDerivation {
    pname = "icat-mini";
    version = "unstable-2025-12-30";
    dontUnpack = true;
    installPhase = ''
      install -Dm755 ${../../config/st/icat-mini.sh} $out/bin/icat-mini
    '';
  };

  nnnSource = pkgs.fetchFromGitHub {
    owner = "jarun";
    repo = "nnn";
    rev = "v5.2";
    sha256 = "sha256-u+88aDHfOZ6bSkg6ahS6eNZWj2QCwJXKW+8nHR99kic=";
  };

  nnnPlugins = pkgs.runCommand "nnn-plugins-5.2" { } ''
    cp -R ${nnnSource}/plugins $out
    chmod -R u+w $out
    substituteInPlace $out/preview-tui \
      --replace-fail \
        'image/jpeg) image_preview "$cols" "$lines" "$1" ;;' \
        'image/jpeg|image/png|image/webp) image_preview "$cols" "$lines" "$1" ;;'
  '';
in
{
  programs.nnn = {
    enable = true;
    package = pkgs-unstable.nnn.override { withNerdIcons = true; };
    extraPackages = [
      icatMini
      pkgs.bc
      pkgs.imagemagick
    ];
    options.a = true;
    plugins = {
      src = nnnPlugins;
      mappings.p = "preview-tui";
    };
    enableBashIntegration = true;
    quitcd = true;
  };

  home.sessionVariables = lib.mkIf (config.my.hm.x11.enable && config.my.hm.x11.wm == "dwm") {
    NNN_TERMINAL = "st";
    NNN_PREVIEWIMGPROG = "icat-mini";
  };
}
