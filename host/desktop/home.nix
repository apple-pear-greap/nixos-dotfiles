{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  nvimPath = "${config.home.homeDirectory}/nix-config/config/nvim";
in
{
  imports = [
    ../../home-modules/yazi.nix
  ];
  home.username = "yuan";
  home.homeDirectory = "/home/yuan";
  home.packages = with pkgs; [
    jq
    fastfetch
    tree
    swaybg
    foot
    rofi
    adwaita-icon-theme
    wl-clipboard
    btop
    protonplus
    pavucontrol
    lazygit
    pamixer
    gamescope
    bluetui
    spotify
    pkg-config
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.firefox.enable = true;
  programs.chromium = {
    enable = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user.name = "Cerydra";
      user.email = "cerydrahysilens@qq.com";
    };
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
    };
  };

  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.waybar;
  };
  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nil
      clang-tools
      lua-language-server

      nixpkgs-fmt

      gcc
      clang
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink nvimPath;
    recursive = true;
  };

  home.stateVersion = "26.05";
}
