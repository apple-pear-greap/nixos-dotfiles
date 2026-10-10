{ ... }:
{
  imports = [
    ./packages.nix
    ./launcher.nix
    ./x11.nix
    ./wayland.nix
    ./audio-switch.nix
    ./notifications.nix
  ];
}
