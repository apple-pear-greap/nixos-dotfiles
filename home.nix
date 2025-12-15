{ config, pkgs, ... }:

{
    imports = [
      ./shell/shell.nix
      ./Editor/nvim.nix
    ];
    home.username = "cerydra";
    home.homeDirectory = "/home/cerydra";
    home.stateVersion = "25.11";
    home.packages = with pkgs; [
      google-chrome
      btop
      bat
      tree
      nerd-fonts.symbols-only
      nixd
      lua-language-server
    ];
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;

      extraConfig = builtins.readFile ./config/wezterm/wezterm.lua;
    };
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
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      
      extensions = with pkgs.vscode-extensions; [
        ms-ceintl.vscode-language-pack-zh-hans
        bbenoist.nix
        sumneko.lua
        catppuccin.catppuccin-vsc
      ];
       
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";

        "Lua.misc.executablePath" = "${pkgs.lua-language-server}/bin/lua-language-server";
        "Lua.telemetry.enable" = false;
        "Lua.workspace.checkThirdParty" = false;
        "Lua.diagnostics.globals" = [ "vim" ];

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nixd}/bin/nixd";

        "editor.fontFamily" = 
          "JetBrains Mono, Noto Sans Mono CJK SC, monospace";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.fontSize" = 18;

        "terminal.integrated.fontFamily" =
          "JetBrains Mono, Noto Sans Mono CJK SC, monospace";
        "terminal.integrated.fontSize" = 16;
      };
    };
    programs.git = {
      enable = true;

      userName = "Cerydra";
      userEmail = "cerydrahysilens@qq.com";
    };

}
