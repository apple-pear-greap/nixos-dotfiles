return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    priority = 100,
    config = function()
        -- 将解析器安装在可写目录，避免 Nix store 只读问题
        local parser_dir = vim.fn.stdpath("data") .. "/treesitter"
        vim.fn.mkdir(parser_dir, "p")
        vim.opt.runtimepath:append(parser_dir)

        -- 安全检查：确保模块存在
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then
            vim.notify("nvim-treesitter not loaded yet", vim.log.levels.WARN)
            return
        end

        configs.setup({
            parser_install_dir = parser_dir,
            auto_install = true,
            ensure_installed = {
                "nix", "lua", "python", "c", "cpp", "javascript", "typescript",
                "rust", "go", "bash", "json", "yaml", "toml",
                "markdown", "markdown_inline", "latex", "html", "css", "vim",
            },

            -- 启用高亮
            highlight = {
                enable = true,
                -- 对大文件禁用高亮以提升性能
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },

            -- 启用增量选择
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = "<TAB>",
                    node_decremental = "<S-TAB>",
                },
            },

            -- 启用基于 Treesitter 的缩进
            indent = {
                enable = true,
            },
        })
    end,
}
