vim.g.mapleader = " "
vim.opt.signcolumn = "yes:1"
vim.opt.cursorlineopt = "number"
vim.opt.wildmode = "noselect"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect,popup"
vim.opt.fillchars = { diff = "╱" }
vim.opt.foldlevel = 99
vim.opt.scrolloff = 15
vim.opt.pumheight = 10
vim.opt.shiftwidth = 2
vim.opt.laststatus = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.number = true
vim.opt.autoread = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.relativenumber = true

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/tpope/vim-surround" },
    { src = "https://github.com/vimwiki/vimwiki" },
})

vim.g.vimwiki_list = { { path = "~/vimwiki", syntax = "markdown", ext = ".md" } }
vim.g.vimwiki_global_ext = 0

local plugins = { "mini.completion", "mini.pick", "mini.icons" }
for _, value in ipairs(plugins) do
    require(value).setup()
end

require("oil").setup({
    view_options = { show_hidden = true },
    lsp_file_methods = { enabled = true, timeout_ms = 1000, autosave_changes = true },
})
require("nvim-treesitter").install({ "rust", "python", "json", "vim", "vimdoc", "lua" }):wait(300000)
require("conform").setup({
    formatters = { ["*"] = { async = true } },
    formatters_by_ft = {
        lua = { "stylua" },
        toml = { "taplo" },
        json = { "prettier" },
        markdown = { "prettier" },
        python = { "ruff_format" },
        -- rust = { "rustfmt" },
    },
})
vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

local opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "v" }, "æ", ":")
vim.keymap.set("n", "U", "<C-R>", opts)
vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>", opts)
vim.keymap.set("n", "<s-tab>", "<cmd>bprev<cr>", opts)
vim.keymap.set("n", "<leader>p", "<cmd>make<cr>", opts)
vim.keymap.set("n", "<leader>o", "<cmd>copen<cr>", opts)
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", opts)
vim.keymap.set("n", "<leader>g", "<cmd>Git<cr>", opts)
vim.keymap.set("n", "<leader>f", "<cmd>Pick files<cr>", opts)
vim.keymap.set("n", "<leader>r", "<cmd>Pick grep_live<cr>", opts)
vim.keymap.set("n", "<leader>y", "<cmd>%y+<cr>", opts)
vim.keymap.set("n", "<leader>js", require("conform").format, opts)
vim.keymap.set("n", "<leader>q", require("mini.bufremove").delete)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "go", require("mini.diff").toggle_overlay)
vim.keymap.set("n", "<Backspace>", ":nohl<cr>", opts)
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", opts)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("t", "<Esc>", "<c-\\><c-n>", opts)

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})
vim.api.nvim_create_autocmd("CmdlineChanged", {
    callback = function()
        if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline():sub(1, 1) == "!" then
            return
        end
        vim.fn.wildtrigger()
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "json", "lua", "rust", "markdown" },
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
    end,
})
vim.diagnostic.config({ underline = true, virtual_text = true })
vim.lsp.enable({ "ty", "ruff", "jsonls", "lua_ls" })
