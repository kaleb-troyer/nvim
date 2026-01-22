-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Kitty window tweaks on start
vim.fn.jobstart({ "kitty", "@", "set-window-title", "nvim" })
vim.fn.jobstart({ "kitty", "@", "set-spacing", "padding=0" })

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        vim.fn.system({ "kitty", "@", "set-window-title", "kitty" })
        vim.fn.system({ "kitty", "@", "set-spacing", "padding=default" })
    end,
})

-- Yank highlight + cmp completion key
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.api.nvim_set_keymap(
            "i",
            "<C-Space>",
            '<Cmd>lua require("cmp").complete()<CR>',
            { noremap = true, silent = true }
        )
        vim.hl.on_yank()
    end,
})
