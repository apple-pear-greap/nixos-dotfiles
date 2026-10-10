{
  config,
  pkgs,
  ...
}:
let
  # Clipboard helper for tmux copy-mode. tmux's `set-clipboard` relies on
  # OSC 52, which some terminals (e.g. st with allowwindowops=0) ignore. Piping
  # the selection to a real clipboard tool works everywhere and autodetects
  # Wayland (wl-copy) vs X11 (xclip).
  tmuxCopy = pkgs.writeShellApplication {
    name = "tmux-copy";
    runtimeInputs = [
      pkgs.wl-clipboard
      pkgs.xclip
    ];
    text = ''
      if [ -n "''${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null 2>&1; then
        exec wl-copy
      fi

      exec xclip -selection clipboard -in
    '';
  };
in
{
  home.packages = with pkgs; [
    # Clipboard backends, so the helper works on both X11 and Wayland.
    xclip
    wl-clipboard
    tmux
    tmuxCopy
  ];
  xdg.configFile.tmux = config.my.xdg.creatSymlink "tmux";
}
