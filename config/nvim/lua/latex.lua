-- LaTeX writing support.
-- vimtex handles compilation (latexmk) and PDF preview (zathura).
-- `texlab` is configured as an LSP in lsp.lua and provided by home-manager
-- (home-modules/latex.nix).

vim.g.tex_flavor = "latex"

-- Compile with latexmk in continuous mode.
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
  continuous = 1,
  options = {
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
  },
}

-- Open the compiled PDF in zathura and enable SyncTeX forward search.
-- `zathura_simple` does not rely on xdotool, so it works on both X11 (dwm)
-- and Wayland (hyprland/plasma).
vim.g.vimtex_view_method = "zathura_simple"
vim.g.vimtex_view_forward_search_on_start = 1

-- Don't spam the quickfix window while typing.
vim.g.vimtex_quickfix_mode = 0
