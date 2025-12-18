return {
    -- LaTeX 支持
    "lervag/vimtex",
    ft = { "latex", "tex" },
    config = function()
        -- 使用系统已有的 zathura 查看
        vim.g.vimtex_view_method = "zathura"

        -- 禁用自动编译
        vim.g.vimtex_compiler_enabled = 0

        -- 启用行内 LaTeX 预览
        vim.g.vimtex_syntax_enabled = 1
    end,
}
