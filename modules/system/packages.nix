{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    tmux
    fzf
    ripgrep
    fd
    nixos-grub2-theme
    nix-output-monitor
    texliveFull
  ];
}
