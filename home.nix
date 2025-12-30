{
  config,
  pkgs,
  ...
}:
{

  imports = [
    ./shell/shell.nix
    ./editor/nvim.nix
    ./editor/vscode.nix
    ./firefox/firefox.nix
  ];

  home.username = "cerydra";
  home.homeDirectory = "/home/cerydra";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # === Browsers ===
    chromium

    # === System Utilities ===
    cmatrix
    btop
    tree
    brightnessctl

    # === Productivity ===
    kitty
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
  qt = {
      enable = true;
      platformTheme.name = "gtk";
      style = {
          name = "adwaita-dark";
          package = pkgs.adwaita-qt;
        };
    };
programs.dankMaterialShell = {
    enable = true;
  };
  # === Terminal Emulator ===
  programs.wezterm = {
    enable = false;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./config/wezterm/wezterm.lua;
  };


  programs.foot = {
      enable = true;
      settings = {
          main = {
              font = "JetBrainsMono Nerd Font:size=14";
            };
        };
    };

  xdg.configFile."kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cerydra/nixos-dotfiles/config/kitty";
      recursive = true;
    };
# === Mango WC Configuration ===
  xdg.configFile."mango" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cerydra/nixos-dotfiles/config/mango";
      recursive = true;
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
  };

  # === GTK Theme & Icons ===
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
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
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
	"application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };
}
