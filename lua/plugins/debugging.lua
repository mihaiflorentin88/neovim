-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/leoluz/nvim-dap-go
-- https://github.com/mfussenegger/nvim-dap-python
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = { "delve", "debugpy", "php-debug-adapter" },
      automatic_installation = true,
    })

    require("dap-go").setup()

    local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    if vim.fn.executable(debugpy_python) == 1 then
      require("dap-python").setup(debugpy_python)
    else
      require("dap-python").setup("python3")
    end

    dap.adapters.php = {
      type = "executable",
      command = "php-debug-adapter",
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
      },
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug (Docker)",
        port = 9003,
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}",
        },
      },
    }

    require("dapui").setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.35 },
            { id = "breakpoints", size = 0.20 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.20 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 12,
          position = "bottom",
        },
      },
    })

    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true,
      commented = false,
    })

    vim.fn.sign_define("DapStopped", {
      text = "*",
      texthl = "DiagnosticWarn",
      linehl = "CursorLine",
      numhl = "DiagnosticWarn",
    })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle debugger breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debugger continue/start" })
    vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Debugger run to cursor" })
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle debugger REPL" })
    vim.keymap.set("n", "<leader>dq", function()
      dap.terminate()
      dapui.close()
    end, { desc = "Terminate debugger session" })
    vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Debugger step into" })
    vim.keymap.set("n", "<F8>", dap.step_over, { desc = "Debugger step over" })
    vim.keymap.set("n", "<F9>", dap.step_out, { desc = "Debugger step out" })
  end,
}
