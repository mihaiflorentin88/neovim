-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/leoluz/nvim-dap-go
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("dap-go").setup()
    require("dapui").setup()

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
