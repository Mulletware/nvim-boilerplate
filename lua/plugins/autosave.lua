return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup {}

    if (not vim.g.autosave_enabled) then
      vim.cmd(":ASToggle")
    end
  end,
}
