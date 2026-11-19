vim.g.netrw_banner = 0
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard:append("unnamedplus")
vim.cmd.colorscheme("retrobox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.pack.add({
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-mini/mini.completion",
  "https://github.com/KanielDasper/codepointer.nvim",
})

vim.keymap.set("n", "grd", vim.lsp.buf.definition)
vim.keymap.set("n", "grf", vim.lsp.buf.format)
vim.keymap.set("n", "grp", require("codepointer").set_codepointer_to_register)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-f>", ":find<Space>")
vim.keymap.set("n", "<C-g>", ":silent grep -e<Space>")
vim.keymap.set("n", "<A-g>", ":silent grep -e <cword><CR>")
vim.keymap.set("n", "-", "<cmd>Explore<cr>")

vim.lsp.enable({
  "jdtls",
  "jsonls",
  "ruff",
  "tsc",
  "tombi",
  "ty",
})

vim.opt.grepprg = "rg --vimgrep"
vim.opt.findfunc = "v:lua.git_ff"
vim.api.nvim_create_autocmd("QuickFixCmdPost", { pattern = { "grep", "make" }, command = "copen" })
function _G.git_ff(arg)
  local files = vim.fn.systemlist('git ls-files')
  return arg == "" and files or vim.fn.matchfuzzy(files, arg)
end

require("mini.completion").setup()
