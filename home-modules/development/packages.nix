{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pkg-config
    nixd
    nixfmt
    clang-tools
    lua-language-server
    clang
    gnumake
    cmake
    nodejs
  ];
}
