{config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # 通过 Nix 提供 Treesitter 及其 grammars
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        nix
        lua
        python
        javascript
        typescript
        rust
        go
        bash
        json
        yaml
        toml
        markdown
        latex
        html
        css
        vim
      ]))
      # Markdown 和 LaTeX 插件
      render-markdown-nvim
      vim-markdown
      vimtex
    ];

    extraPackages = with pkgs; [
      gcc
      gnumake
      cmake
      pkg-config

      nodejs
      python3

      lua-language-server
      nil

      stylua
      alejandra
      shfmt
      shellcheck

      fzf
      ripgrep
      
      # LaTeX 支持
      texlive.combined.scheme-basic
      python3Packages.pylatexenc
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/cerydra/nixos-dotfiles/editor/nvim";
    recursive = true;
  };

}
