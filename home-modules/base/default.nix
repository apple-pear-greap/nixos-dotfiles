{ inputs, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
    ../../libs/xdg-links.nix
    ./user.nix
    ./xdg.nix
  ];
}
