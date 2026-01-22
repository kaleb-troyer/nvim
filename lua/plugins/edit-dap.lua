return {
    {
        "mfussenegger/nvim-dap",
        enabled = true,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
        },
        keys = {
            { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<leader>gb", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
            { "<F1>", function() require("dap").continue() end, desc = "Continue" },
            { "<F2>", function() require("dap").step_into() end, desc = "Step into" },
            { "<F3>", function() require("dap").step_over() end, desc = "Step over" },
            { "<F4>", function() require("dap").step_out() end, desc = "Step out" },
            { "<F5>", function() require("dap").step_back() end, desc = "Step back" },
            { "<F13>", function() require("dap").restart() end, desc = "Restart" },
            { "<space>?", function() require("dapui").eval(nil, { enter = true }) end, desc = "Evaluate expression" },
        },
        config = function()
            local dap = require("dap")
            -- local ui = require("dapui")

            -- Python DAP setup
            require("dap-python").setup("python3")

            -- C++/C/Rust setup with lldb
            dap.adapters.lldb = {
                type = "executable",
                command = "lldb-vscode", -- or lldb-dap
                name = "lldb",
            }

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                    runInTerminal = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            -- Breakpoint signs
            vim.fn.sign_define("DapBreakpoint", { text = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "" })
            vim.fn.sign_define("DapStopped", { text = "" })

        end,
    },
}
