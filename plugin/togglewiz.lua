if vim.g.loaded_togglewiz then
  return
end
vim.g.loaded_togglewiz = true

-- Define command to open the toggle UI
vim.api.nvim_create_user_command("ToggleWiz", function()
  require("togglewiz.telescope").open()
end, {})
