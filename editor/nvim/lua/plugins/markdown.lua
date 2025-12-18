return {
    -- Markdown 和 LaTeX 渲染
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    ft = { "markdown", "latex", "text" },
    config = function()
        require("render-markdown").setup({
            -- 启用所有渲染器
            enabled = true,

            -- Markdown 标题渲染
            heading = {
                enabled = true,
                sign = "󰲡",
                icons = { "󰲢 ", "󰲣 ", "󰲤 ", "󰲥 ", "󰲦 ", "󰲧 " },
            },

            -- 代码块渲染
            code = {
                enabled = true,
                style = "full",
                position = "left",
            },

            -- 列表渲染
            bullet = {
                enabled = true,
                icons = { "●", "○", "◆", "◇" },
            },

            -- 链接渲染
            link = {
                enabled = true,
                hyperlink = true,
            },

            -- 斜体和粗体
            italic = {
                enabled = true,
            },

            checkbox = {
                enabled = true,
                unchecked = "󰄱 ",
                checked = "󰄲 ",
            },

            -- LaTeX 数学公式渲染
            latex = {
                enabled = true,
                top_pad = 0,
                bottom_pad = 0,
            },

            -- 表格渲染
            table = {
                enabled = true,
            },
        })
    end,
}
