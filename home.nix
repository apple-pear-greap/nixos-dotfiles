{ inputs, config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    inputs.mangobar.homeManagerModules.default
  ];
  home.username = "yuan";
  home.homeDirectory = "/home/yuan";
  home.packages = with pkgs;[
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
    pamixer
    gamescope
    bluetui
    spotify
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
  services.mangobar = {
    enable = true;
    systemdTarget = "mango.target";
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

    extraPackages = with pkgs; [
      nil
      lua-language-server

      nixpkgs-fmt

      gcc
      clang
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/yuan/nixos-config/config/nvim/";
    recursive = true;
  };

  programs.ghostty.enable = true;
  home.stateVersion = "26.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
    };
  };
}
