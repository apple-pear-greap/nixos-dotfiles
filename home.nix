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
    btop
    tree
    brightnessctl

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
  programs.kitty = {
    enable = true;
    font = {
	size = 14;
	name = "JetBrainsMono Nerd Font";
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
	    background_opacity = "0.8";
	    hide_window_decorations = "yes";

      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      copy_on_select = "yes";

      input_delay = 3;
      sync_to_monitor = "yes";
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
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
	"application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };

}
