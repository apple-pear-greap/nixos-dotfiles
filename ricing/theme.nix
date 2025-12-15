{ pkgs, config, ... }:

{
  # =================================================================
  # 1. 强制设置环境变量
  # 这是在不同 WM/DE 间保持一致的关键。
  # =================================================================
  home.sessionVariables = {
    # 强制 GTK 应用使用这个主题名 (忽略 KDE 的设置)
    GTK_THEME = "catppuccin-mocha-blue-standard";
    # 强制 Qt 应用使用 kvantum 引擎 (能完美模拟 GTK 主题)
    QT_QPA_PLATFORMTHEME = "kvantum";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  # =================================================================
  # 2. GTK 主题配置 (通用)
  # Home Manager 生成后，文件是只读的，KDE 无法篡改。
  # =================================================================
  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-mocha-blue-standard";
      # 使用 override 自定义细节
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };

    # 强制写入 GTK 设置，防止 KDE 覆盖
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # 必须开启 dconf 才能让 GTK4 (Libadwaita) 应用变黑
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # =================================================================
  # 3. Qt 主题配置 (Kvantum 方案)
  # Kvantum 是最通用的 Qt 主题引擎，支持 Catppuccin。
  # =================================================================
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # 安装 Kvantum 主题包和引擎
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum # Qt6 支持
    
    # 安装 Catppuccin 的 Kvantum 主题文件
    (catppuccin-kvantum.override {
      accent = "blue";
      variant = "mocha";
    })
  ];

  home.pointerCursor = {
    gtk.enable = true;
    name = "catppuccin-mocha-blue-cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 24;
  };
  # 直接生成 Kvantum 配置文件
  # 这一步很关键，它告诉 Kvantum 引擎去用 Catppuccin
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha-Blue
  '';
  
  # 很多 Qt 应用 (如 VirtualBox, VLC) 需要这个
  xdg.configFile."Kvantum/Catppuccin-Mocha-Blue".source = "${pkgs.catppuccin-kvantum.override { accent = "blue"; variant = "mocha"; }}/share/Kvantum/Catppuccin-Mocha-Blue";
}
