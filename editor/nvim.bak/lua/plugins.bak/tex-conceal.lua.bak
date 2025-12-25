return {
    "KeitaNakamura/tex-conceal.vim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "tex", "latex", "markdown" },
    config = function()
        -- 将常见的 TeX 运算符/希腊字母/定界符等替换为 Unicode 符号
        -- 需要 conceallevel=2 才会生效（已在 option.lua 设置）
        vim.g.tex_conceal = "abdmg"
        -- 让 markdown 中 $...$ 触发 tex 语法（vim-markdown 已开启 math）
        vim.g.vim_markdown_math = 1
        vim.g.vim_markdown_conceal = 1
    end,
}
