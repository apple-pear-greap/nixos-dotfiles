{ pkgs, pkgs-unstable, ... }:
{
  programs.nnn = {
    enable = true;
    package = pkgs-unstable.nnn.override { withNerdIcons = true; };
    plugins = {
      src =
        (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v5.2";
          sha256 = "sha256-u+88aDHfOZ6bSkg6ahS6eNZWj2QCwJXKW+8nHR99kic=";
        })
        + "/plugins";
      mappings.p = "preview-tui";
    };
    enableBashIntegration = true;
    quitcd = true;
  };
}
