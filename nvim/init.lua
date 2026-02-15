-- Tanky Woo's Neovim Configuration
-- Phase 1: Basic Options & Mappings (Migrated from Vim 9.1)

-- 1. 基础设置 (Basic Options)
vim.g.mapleader = "\\"       -- Leader 键
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- =============================================
-- 1.1 显示与外观 (UI & Appearance)
-- =============================================
opt.number = true                -- 显示行号
opt.relativenumber = false       -- 不使用相对行号
opt.signcolumn = "yes"           -- 总是显示侧边栏 (避免 LSP 报错时抖动)
opt.cursorline = true            -- 高亮当前行
opt.colorcolumn = "81"           -- 80字符提示线
opt.list = true                  -- 显示不可见字符
opt.listchars:append("tab:>-")   -- Tab 显示为 >-
opt.listchars:append("trail:.")  --行尾空格显示为 .
opt.showmatch = true             -- 插入括号时高亮匹配项

-- =============================================
-- 1.2 缩进 (Indentation)
-- =============================================
opt.tabstop = 4                  -- Tab 宽度
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true             -- 使用空格代替 Tab
opt.autoindent = true
opt.smartindent = true

-- =============================================
-- 1.3 搜索 (Search)
-- =============================================
opt.ignorecase = true            -- 忽略大小写
opt.smartcase = true             -- ...除非包含大写字母
opt.hlsearch = true              -- 高亮搜索结果
opt.incsearch = true             -- 实时增量搜索

-- =============================================
-- 1.4 编辑与交互 (Editing & Interaction)
-- =============================================
opt.mouse = ""                   -- 禁用鼠标 (符合纯键盘流习惯)
opt.backspace = { "indent", "eol", "start" } -- 增强退格键行为
opt.clipboard:append("unnamedplus") -- 使用系统剪贴板
opt.foldmethod = "indent"        -- 基于缩进折叠
opt.foldlevel = 99               -- 默认打开所有折叠

-- =============================================
-- 1.5 文件与编码 (Files & Encoding)
-- =============================================
opt.backup = false               -- 禁用备份文件
opt.fileencodings = { "utf-8", "gb18030", "cp936", "big5" } -- 编码猜测顺序
opt.fileencoding = "utf-8"       -- 默认写入编码
opt.splitright = true            -- vsplit 新窗口在右侧
opt.splitbelow = true            -- split 新窗口在下方

-- =============================================
-- 1.6 基础映射 (Basic Keymaps)
-- =============================================
local map = vim.keymap.set

-- <C-l> 清除搜索高亮
map("n", "<C-l>", ":nohlsearch<CR><C-l>", { silent = true })

-- <leader>w 保存
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- <leader>l 切换不可见字符显示
map("n", "<leader>l", ":set list!<CR>", { silent = true, desc = "Toggle listchars" })

-- <leader>p 粘贴模式 (模拟 vimrc 中的逻辑)
map("n", "<leader>p", ':set paste<CR>"+p:set nopaste<CR>', { desc = "Paste from clipboard" })

-- %% 命令行模式下快速展开当前文件目录
map("c", "%%", function()
    if vim.fn.getcmdtype() == ':' then
        return vim.fn.expand('%:h') .. '/'
    else
        return '%%'
    end
end, { expr = true, desc = "Expand directory" })

-- =============================================
-- 1.7 自动命令 (Autocommands)
-- =============================================
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 1.7.1 自动插入文件头 (Auto Header)
-- Python
autocmd("BufNewFile", {
    pattern = "*.py",
    callback = function()
        local header = {
            "#!/usr/bin/env python",
            "# -*- coding: utf-8 -*-",
            "# Tanky Woo @ " .. os.date("%Y-%m-%d"),
            "",
        }
        vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
        vim.cmd("normal! G") -- 跳转到文件末尾
    end,
})
-- Bash
autocmd("BufNewFile", {
    pattern = "*.sh",
    callback = function()
        local header = {
            "#!/bin/bash",
            "# Tanky Woo @ " .. os.date("%Y-%m-%d"),
            "",
        }
        vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
        vim.cmd("normal! G")
    end,
})

-- 1.7.2 特定文件类型的缩进设置 (FileType Indent)
local function set_indent(files, width)
    autocmd("FileType", {
        pattern = files,
        callback = function()
            vim.opt_local.shiftwidth = width
            vim.opt_local.tabstop = width
            vim.opt_local.softtabstop = width
            vim.opt_local.expandtab = true
        end,
    })
end

-- 2 空格缩进: 前端相关 + Vim
set_indent({ "html", "htmldjango", "css", "javascript", "typescript", "vim", "lua", "yaml", "json" }, 2)
-- 4 空格缩进: Python, Shell (虽然默认是4，显式设置更安全)
set_indent({ "python", "sh", "zsh" }, 4)

-- 1.7.3 Diff 模式优化 (Diff Mode)
-- 在 Diff 模式下禁用折叠，方便阅读
local diff_group = augroup("MyDiff", { clear = true })
autocmd({ "VimEnter", "DiffUpdated" }, {
    group = diff_group,
    callback = function()
        if vim.wo.diff then
            vim.opt_local.foldenable = false
            vim.opt_local.foldmethod = "manual"
        end
    end,
})

-- -----------------------------------------------------------
-- Phase 2: Plugin Manager (Lazy.nvim)
-- -----------------------------------------------------------

-- 1. 自动安装 Lazy.nvim (Bootstrap)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. 插件列表 (Plugins)
require("lazy").setup({
    -- 2.1 配色主题 (替换 apprentice)
    { 
        "ellisonleao/gruvbox.nvim", 
        priority = 1000, 
        config = true, 
        opts = {
            contrast = "hard", -- 类似 apprentice 的深色高对比
        }
    },

    -- 2.2 文件浏览器 (替换 NERDTree)
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- 图标支持
        config = function()
            require("nvim-tree").setup({
                filters = { dotfiles = false }, -- 显示 .config 这里文件方便调试
            })
            -- 保持你的习惯: <leader>ne
            vim.keymap.set("n", "<leader>ne", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
        end,
    },

    -- 2.3 语法高亮 (Nvim-Treesitter)
    -- 核心逻辑:
    -- 1. build = ":TSUpdate": 每次更新插件时自动更新解析器
    -- 2. ensure_installed: 自动安装你常用的语言解析器
    -- 3. highlight.enable: 启用基于 AST 的高亮
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- 加上这行保护逻辑
            local status, configs = pcall(require, "nvim-treesitter.configs")
            if not status then
                return
            end

            configs.setup({
                -- 自动安装这些语言的 parser
                ensure_installed = { 
                    "c", "lua", "vim", "vimdoc", "query", -- Neovim 自身依赖
                    "python", "bash", "markdown", "markdown_inline" -- 你的常用语言
                },
                -- 启用高亮模块
                highlight = {
                    enable = true,
                    -- 如果遇到极大文件，为了性能可以临时禁用
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    -- 这里的 regex 兼容是为了在某些极小众语言下回退到 regex
                    additional_vim_regex_highlighting = false,
                },
                --启用基于 Treesitter 的缩进模块 (实验性但很好用)
                indent = { enable = true },
            })
        end,
    },

    -- 2.4 模糊查找 (Telescope)
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            -- 可选：安装 fzf-native 提升排序性能 (需要系统安装cmake)
            -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } 
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            
            telescope.setup({
                defaults = {
                    -- 这里的配置可以调整 UI
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous, -- 上移
                            ["<C-j>"] = actions.move_selection_next,     -- 下移
                        },
                    },
                },
            })

            -- 核心快捷键
            local builtin = require("telescope.builtin")
            -- Find Files (找文件)
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            -- Live Grep (找内容) - 需要 ripgrep
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            -- Find Buffers (找已打开文件)
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            -- Find Help (找帮助文档)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
        end,
    },

    -- 2.5 状态栏 (lualine) - 提升颜值
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = { theme = "gruvbox" }
            })
        end,
    },

    -- =========================================================================
    -- Phase 3: IDE Capabilities (LSP & Completion)
    -- =========================================================================
    
    -- 3.1 LSP 管理 (Mason)
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    
    -- 3.2 LSP 配置 (LspConfig)
    -- 负责将 Neovim 连接到 Mason 安装的 Language Servers
    {
        "neovim/nvim-lspconfig",
        dependencies = { 
            "williamboman/mason.nvim", 
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- 1. 自动安装 Server
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "bashls" } 
            })

            -- 2.0 配置诊断显示样式 (新增)
            vim.diagnostic.config({
                virtual_text = true,     -- 在行尾显示错误信息 (如果不喜欢可以设为 false)
                signs = true,            -- 在侧边栏显示图标
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                },
            })

            -- 2. 通用能力配置 (Capabilities)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 3. 批量启动 Servers (适配 Neovim 0.11+)
            local servers = { "pyright", "bashls", "lua_ls" }

            for _, server in ipairs(servers) do
                -- 构造配置表
                local opts = {
                    capabilities = capabilities,
                }

                -- Lua 特殊配置
                if server == "lua_ls" then
                    opts.settings = {
                        Lua = { diagnostics = { globals = { "vim" } } }
                    }
                end

                -- 核心改动 (Neovim 0.11+):
                if vim.lsp.config then
                    vim.lsp.config(server, opts)
                end
                vim.lsp.enable(server)
            end
            
            -- 4. 自动绑定快捷键 (LspAttach 事件)
            -- 以前是在 on_attach 里写，现在官方推荐用 autocmd
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    -- 跳转定义 (Gd)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    -- 查看文档 (K)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    -- 重命名 (<leader>rn)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    -- 代码操作 (<leader>ca)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    -- 查看错误详情 (<leader>d)
                    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                    -- 跳转错误 ([d, ]d)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })
        end,
    },

    -- 3.3 补全引擎 (Cmp)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",    -- 这里是 nvim-cmp 和 LSP 的桥梁
            "hrsh7th/cmp-buffer",      -- 补全当前文件内容
            "hrsh7th/cmp-path",        -- 补全系统路径
            "L3MON4D3/LuaSnip",        -- Snippet 引擎 (必须)
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(), -- Tab 下一个
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Shift+Tab 上一个
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 回车确认
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- 优先级最高：LSP
                    { name = "luasnip" },  -- Snippet
                }, {
                    { name = "buffer" },   -- 其次：当前文件
                    { name = "path" },     -- 路径
                })
            })
        end,
    }
})

-- 3. 应用配色
vim.cmd("colorscheme gruvbox")
