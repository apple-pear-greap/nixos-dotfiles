{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    
    extensions = with pkgs.vscode-extensions; [
      # Language support
      bbenoist.nix
      sumneko.lua
      
      # AI assistance
      github.copilot
      github.copilot-chat
      
      # Theme & appearance
      catppuccin.catppuccin-vsc
      
      # Localization
      ms-ceintl.vscode-language-pack-zh-hans
    ];
     
    userSettings = {
      # Theme
      "workbench.colorTheme" = "Catppuccin Mocha";

      # Lua language server
      "Lua.misc.executablePath" = "${pkgs.lua-language-server}/bin/lua-language-server";
      "Lua.telemetry.enable" = false;
      "Lua.workspace.checkThirdParty" = false;
      "Lua.diagnostics.globals" = [ "vim" ];

      # Nix language server
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";

      # Editor fonts
      "editor.fontFamily" = 
        "JetBrainsMono Nerd Font, Noto Sans Mono CJK SC, monospace";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.fontSize" = 18;

      # Terminal fonts
      "terminal.integrated.fontFamily" =
        "JetBrainsMono Nerd Font, Noto Sans Mono CJK SC, monospace";
      "terminal.integrated.fontSize" = 16;
    };
  };
}
