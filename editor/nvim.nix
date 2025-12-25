{  pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";

    # basic options
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      termguicolors = true;
    };

# theme
    colorschemes.tokyonight.enable = true;

# treesitter
    plugins.treesitter = {
      enable = true;
      settings.highlight.enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nix
        lua
        vimdoc
        python
        latex
        markdown
        bash
        c
        cpp
      ];
    }; 

# LSP
    plugins.lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;
        pyright.enable = true;
        lua_ls.enable = true;
        texlab.enable = true;
        clangd.enable = true;
      };
      keymaps.lspBuf = {
        "gd" = "definition";
        "K" = "hover";
        "gr" = "references";
        "<leader>rn" = "rename";
      };
    };

# CMP for command complete
    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      settings.mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = "cmp.mapping.select_next_item()";
        "<S-Tab>" = "cmp.mapping.select_prev_item()" ;
      };
    };

# Snacks -- a tools with many function
    plugins.snacks = {
      enable = true;
      settings = {
        picker.enable = true;
        image.enable = true;
        explorer.enable = true;
        dashboard = {
          enable = true;
          sections = [
            { section = "header"; }
            { section = "keys"; gap = 1; }
          ];
        };
      };
    };

#mini.nvim for some small modules
    plugins.mini = {
      enable = true;
      modules = {
        ai = {};
        surround = {};
        pairs = {};
        icons = {};
        statusline = {};
      };
    };

#LaTex
    plugins.vimtex = {
      enable = true;
      settings = {
        view_method = "zathura";
        quickfix_mode = 0;
      };
    };

    keymaps = [
# basic keymap for nvim
     { mode = "n"; key = "<leader>w"; action = ":w<CR>"; options.desc = "save document"; } 
     { mode = "n"; key = "<leader>q"; action = ":q<CR>"; options.desc = "quit"; } 
     { mode = "n"; key = "<ESC>"; action = ":noh<CR>"; options.desc = "clean high light"; } 

# vimtex
    {mode = "n"; key = "<leader>ll"; action = "<cmd>VimtexCompile<cr>"; options.desc = " Compile LaTeX"; }
    {mode = "n"; key = "<leader>lv"; action = "<cmd>VimtexView<cr>"; options.desc = "View PDF"; }
    {mode = "n"; key = "<leader>lc"; action = "<cmd>VimtexClean<cr>"; options.desc = "Clean"; }

#snacks.nvim
    { mode = "n"; key = "<leader>ff"; action = ":lua Snacks.picker.files()<CR>"; options.desc = "Find files";}
    { mode = "n"; key = "<leader>fg"; action = ":lua Snacks.picker.git_files()<CR>"; options.desc = "Find git files";}
    { mode = "n"; key = "<leader>fr"; action = ":lua Snacks.picker.recent()<CR>"; options.desc = "Find recent files";}
    { mode = "n"; key = "<leader>/"; action = ":lua Snacks.picker.grep()<CR>"; options.desc = "grep";}
    { mode = "n"; key = "<leader>e"; action = ":lua Snacks.explorer()<CR>"; options.desc = "Open snacks files"; }

# mini.nvim
#mini.files

# move around windows
     { mode = "n"; key = "<C-h>"; action = "<C-w>h"; }
     { mode = "n"; key = "<C-j>"; action = "<C-w>j"; }
     { mode = "n"; key = "<C-k>"; action = "<C-w>k"; }
     { mode = "n"; key = "<C-l>"; action = "<C-w>l"; }
    ];
  };

  home.packages = with pkgs; [
    texliveFull
    xdotool
  ];

}
