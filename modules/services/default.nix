{ inputs, ... }:
{
  imports = [
    ./ssh.nix
    inputs.agenix.nixosModules.default
  ];
}
