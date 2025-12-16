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
      wpsoffice-cn
      
      # === Media ===
      splayer
      
      # === Fonts & Icons ===
      (nerd-fonts.jetbrains-mono)
      papirus-icon-theme
      
      # === Language Servers & Dev Tools ===
      nixd
      lua-language-server
      
      # === Build Tools (for nvim-treesitter) ===
      gcc
      gnumake
      tree-sitter
      # nodejs  # Uncomment if needed for some parsers
    ];
    # === Terminal Emulator ===
    programs.wezterm = {
      enable = false;
      enableZshIntegration = true;
      extraConfig = builtins.readFile ./config/wezterm/wezterm.lua;
    };

    # === Niri Configuration ===
    xdg.configFile."niri" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cerydra/nixos-dotfiles/config/niri";
      recursive = true;
    };

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

}
