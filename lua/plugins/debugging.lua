-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/leoluz/nvim-dap-go
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("dap-go").setup()
    require("dapui").setup({
      elements = {
        id = "console",
        size = 20,
        position = "bottom",
      },
    })

    -- Setup nvim-dap-virtual-text to display inline variable values
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true, 
      commented = false, 
    })
   
    -- Define a custom sign to highlight the current line when stopped
    vim.fn.sign_define("DapStopped", {
      text = "🔴",
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
    vim.keymap.set("n", "<Leader>du", require("dapui").toggle, { desc = "Toggle DAP UI" })
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", function()
      dap.continue()
    end)
    vim.keymap.set("n", "<F7>", function()
      dap.step_into()
    end)
    vim.keymap.set("n", "<F8>", function()
      dap.step_over()
    end)
    vim.keymap.set("n", "<F9>", function()
      dap.step_out()
    end)
 end
}
