{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  programs.spicetify = {
    enable = true;
    # Keep the default Spotify appearance; only add client-side ad blocking.
    enabledExtensions = [ spicePkgs.extensions.adblockify ];
  };
}
