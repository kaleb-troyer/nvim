
if vim.loader then
	vim.loader.enable()
end

require("config.lazy")

vim.cmd.colorscheme('rose-pine')
