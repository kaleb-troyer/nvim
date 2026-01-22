-- lua/themes/init.lua

local themes = {
    "bamboo",
    "catppuccin",
    "everforest",
    "gruvbox-material",
    "rose-pine",
    "sonokai",
}

-- merge all plugin tables dynamically
local plugins = {}
for _, name in ipairs(themes) do
    local ok, theme_tbl = pcall(require, "themes." .. name)
    if ok and theme_tbl then
        vim.list_extend(plugins, theme_tbl)
    else
        vim.notify("Failed to load theme: " .. name, vim.log.levels.WARN)
    end
end

return plugins
