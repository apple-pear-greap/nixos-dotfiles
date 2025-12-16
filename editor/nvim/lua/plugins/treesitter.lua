return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- 避免在只读路径编译，放到本地可写目录
            parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
            sync_install = false,
            auto_install = false,
            ensure_installed = {
                "lua",
                "nix",
                "bash",
                "python",
                "json",
                "yaml",
                "toml",
                "vim",
                "vimdoc",
                "markdown",
                "markdown_inline",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
        },
        config = function(_, opts)
            local ok, mod = pcall(require, "nvim-treesitter.configs")
            if not ok then
                ok, mod = pcall(require, "nvim-treesitter.config")
            end
            if ok and mod then
                mod.setup(opts)
            else
                vim.notify("nvim-treesitter config module not found", vim.log.levels.ERROR)
            end
        end,
    },
}
