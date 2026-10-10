{ inputs, ... }:
{
  imports = [ inputs.helium-flake.homeModules.default ];
  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--enable-features=AcceleratedVideoDecodeLinuxGL"
    ];
  };
}
