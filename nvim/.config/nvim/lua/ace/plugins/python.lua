return {
  "mfussenegger/nvim-dap-python",
  ft = { "py" },
  config = function()
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path)
  end,
}
