{
  config,
  libs,

  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = [ pkgs-unstable.pi-coding-agent ];
}
