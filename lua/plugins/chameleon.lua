
-- Lua (chameleon.lua)
return {
  "shaun-mathew/Chameleon.nvim",
  config = function()
    -- override the plugin with the patched version
    local M = {}
    local fn = vim.fn
    local api = vim.api
    M.original_color = nil
    M.original_opacity = nil

    local function get_kitty_background()
      if M.original_color == nil then
        local result = fn.systemlist({ "kitty", "@", "get-colors" })
        for _, line in ipairs(result) do
          if string.match(line, "^background") then
            local color = vim.split(line, "%s+")[2]
            M.original_color = color
            break
          end
        end
      end
    end

    local function get_kitty_opacity()
      if M.original_opacity == nil then
        local result = vim.fn.systemlist({ "kitty", "@", "ls" })
        local json_str = table.concat(result, "\n")
    
        local ok, data = pcall(vim.fn.json_decode, json_str)
        if not ok or type(data) ~= "table" then
          vim.api.nvim_err_writeln("Failed to parse kitty @ ls output")
          return nil
        end
    
        for _, instance in ipairs(data) do
          if instance.is_active and instance.background_opacity then
            M.original_opacity = instance.background_opacity
            break
          end
        end
      end
    end
   
    local function change_background(color, opacity, sync)
      local arg = 'background="' .. color .. '"'
      local commandA = "kitty @ set-colors " .. arg
      local commandB = "kitty @ set-background-opacity " .. tostring(opacity)
      if not sync then
        fn.jobstart(commandA, {
          on_stderr = function(_, d, _)
            if #d > 1 then
              api.nvim_err_writeln(
                "Chameleon.nvim: Error changing background. Make sure kitty remote control is turned on."
              )
            end
          end,
        })

        fn.jobstart(commandB, {
          on_stderr = function(_, d, _)
            if #d > 1 then
              api.nvim_err_writeln(
                "Chameleon.nvim: Error changing opacity. Make sure kitty dynamic background opacity is turned on."
              )
            end
          end,
        })
      else
        fn.system(commandA)
        fn.system(commandB)
      end
    end

    local function update_to_normal_bg()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      if normal and normal.bg then
        local color = string.format("#%06X", normal.bg)
        change_background(color, .95)
      end
    end

    local function setup_autocmds()
      local autocmd = api.nvim_create_autocmd
      local autogroup = api.nvim_create_augroup
      local bg_change = autogroup("BackgroundChange", { clear = true })

      autocmd({ "ColorScheme", "VimResume" }, {
        pattern = "*",
        callback = update_to_normal_bg,
        group = bg_change,
      })

      autocmd("User", {
        pattern = "NvChadThemeReload",
        callback = update_to_normal_bg,
        group = bg_change,
      })

      autocmd({ "VimLeavePre", "VimSuspend" }, {
        callback = function()
          if M.original_color ~= nil and M.original_opacity ~= nil then
            change_background(M.original_color, M.original_opacity, true)
          end
        end,
        group = autogroup("BackgroundRestore", { clear = true }),
      })
    end

    M.setup = function()
      get_kitty_background()   -- blocking fetch
      get_kitty_opacity()
      setup_autocmds()
      update_to_normal_bg()    -- force sync once at startup
    end

    M.setup()
  end,
}
