{
  pkgs,
  ...
}:
{
  # LaTeX writing environment for Neovim.
  #
  # texliveFull is already provided system-wide (modules/core.nix); here we
  # add the pieces Home Manager should own: the texlab language server and a
  # PDF reader with SyncTeX support (used by vimtex for forward/inverse search).

  home.packages = with pkgs; [
    texlab
  ];

  # Zathura is installed and configured by this module; `programs.zathura`
  # adds the package to home.packages as well.
  programs.zathura = {
    enable = true;
    options = {
      # Reuse the current window instead of spawning a new one.
      "dbus-service" = true;
      "selection-clipboard" = "clipboard";
      "window-title-basename" = true;
    };
    extraConfig = ''
      # Optional fallback for manually opened documents. VimTeX already passes
      # the equivalent `-x` command when it launches zathura itself.
      set synctex-editor-command "nvim --headless -c \"VimtexInverseSearch %{line}:%{column} '%{input}'\""
    '';
  };
}
