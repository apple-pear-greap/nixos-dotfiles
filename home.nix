{ config, pkgs, ... }:

{
  imports = [
    ./shell/shell.nix
    ./editor/nvim.nix
    ./editor/vscode.nix
    # ./ricing/theme.nix
  ];

  home.username = "cerydra";
  home.homeDirectory = "/home/cerydra";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # === Browsers ===
    google-chrome
    firefox

    # === System Utilities ===
    btop
    tree
    fastfetch

    # === Productivity ===
    localsend
    steam-run
    wpsoffice-cn
    wechat-uos

    # === Media ===
    splayer

    # === Fonts & Icons ===
    (nerd-fonts.jetbrains-mono)
    papirus-icon-theme
    hicolor-icon-theme
    adwaita-icon-theme

    # === Language Servers & Dev Tools ===
    nixd
    lua-language-server

    # === Build Tools (for nvim-treesitter) ===
    gcc
    gnumake
    tree-sitter
    python3Packages.pylatexenc
    nodejs # Uncomment if needed for some parsers
    yarn
  ];
  # === Terminal Emulator ===
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./config/wezterm/wezterm.lua;
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrains Mono:size=16";
      };
    };
  };

  # === Niri Configuration ===
  xdg.configFile."niri" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/cerydra/nixos-dotfiles/config/niri";
    recursive = true;
  };

  # === Fuzzel Configuration (hot-reload) ===
  xdg.configFile."fuzzel/fuzzel.ini".source =
    config.lib.file.mkOutOfStoreSymlink "/home/cerydra/nixos-dotfiles/config/fuzzel/fuzzel.ini";

  # === Waybar Configuration (hot-reload enabled) ===
  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/cerydra/nixos-dotfiles/config/waybar";
    recursive = true;
  };

  # === Terminal Enhancements ===
  programs.bat = {
    enable = true;
    catppuccin.enable = true;
  };

  # === Terminal Emulator (disabled in favor of wezterm) ===
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrains Mono";
      size = 16;
    };
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.85";
    };
  };

  # === GTK Theme & Icons ===
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
      };
    };
  };

  # === Version Control ===
  programs.git = {
    enable = true;
    settings = {
      user.name = "Cerydra";
      user.email = "cerydrahysilens@qq.com";
    };
  };
  # === pdf viewer ===
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      font = "JetBrains Mono 16";

      default-bg = "#282a36";
      default-fg = "#f8f8f2";
      statusbar-bg = "#44475a";
      statusbar-fg = "#f8f8f2";
    };
  };

}
