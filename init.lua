vim.g.netrw_banner = 0
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.path:append("src/**,static/,config/")
vim.opt.clipboard:append("unnamedplus")
vim.opt.wildignore:append("*/__pycache__/*,*/node_modules/*")

vim.cmd.colorscheme({ "retrobox" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-mini/mini.completion",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/tpope/vim-fugitive",
})

vim.keymap.set("n", "grd", vim.lsp.buf.definition)
vim.keymap.set("n", "grf", vim.lsp.buf.format)
vim.keymap.set("n", "-", require("oil").open)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-f>", ":find<Space>")
vim.keymap.set("n", "<C-g>", function()
  vim.cmd("silent! grep" .. vim.fn.input(":grep "))
  vim.cmd("copen")
end)

vim.lsp.enable({
  "lua_ls",
  "tsc",
  "jdtls",
  "jsonls",
  "tombi",
  "pyrefly",
  "ruff",
})

require("mini.completion").setup()
require("oil").setup({ view_options = { show_hidden = true } })
