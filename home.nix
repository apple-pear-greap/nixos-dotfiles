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
      
      # === Fonts ===
      (nerd-fonts.jetbrains-mono)
      
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
      enable = true;
      enableZshIntegration = true;
      extraConfig = builtins.readFile ./config/wezterm/wezterm.lua;
    };
    # === Terminal Enhancements ===
    programs.bat = {
      enable = true;
      catppuccin.enable = true;
    };
    
    # === Terminal Emulator (disabled in favor of wezterm) ===
    programs.kitty = {
      enable = false;
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
    
    # === Version Control ===
    programs.git = {
      enable = true;
      settings = {
	user.name = "Cerydra";
	user.email = "cerydrahysilens@qq.com";
      };
    };

}
