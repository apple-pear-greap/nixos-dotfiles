{ config, pkgs, ... }:

{
  # Fonts configuration
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    source-han-sans
    sarasa-gothic
    wqy_microhei
    wqy_zenhei
    jetbrains-mono
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      # 先用拉丁字体，中文再回退到思源/苹方系，避免英文符号变宽
      monospace = [ "JetBrains Mono" "DejaVu Sans Mono" "Noto Sans Mono" "Noto Sans Mono CJK SC" "Sarasa Mono SC" ];
      sansSerif = [ "Noto Sans" "DejaVu Sans" "Source Han Sans SC" "Noto Sans CJK SC" ];
      serif = [ "Noto Serif" "DejaVu Serif" "Source Han Serif SC" "Noto Serif CJK SC" ];
    };
  };
}
