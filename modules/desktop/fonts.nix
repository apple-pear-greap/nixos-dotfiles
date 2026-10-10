{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.fonts.enable = lib.mkEnableOption "Desktop fonts and fontconfig defaults";

  config = lib.mkIf config.my.fonts.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      source-han-sans
      sarasa-gothic
      wqy_microhei
      wqy_zenhei
      noto-fonts-color-emoji
      fira-code
      nerd-fonts.jetbrains-mono
      maple-mono.NF-CN
    ];
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "JetBrainsMonoNL NF"
          "Maple Mono NF CN"
          "Noto Sans Mono"
          "Noto Sans Mono CJK SC"
          "Sarasa Mono SC"
        ];
        sansSerif = [
          "Noto Sans"
          "DejaVu Sans"
          "Source Han Sans SC"
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif"
          "DejaVu Serif"
          "Source Han Serif SC"
        ];
      };
    };
  };
}
