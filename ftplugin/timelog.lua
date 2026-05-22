-- loaded for yaml.timelog compound filetype
local map = vim.keymap.set

map("n", "m", ":!process_time_log.py %<CR>", { buffer = true })
map("n", "<localleader>g", function()
  local ts = vim.fn.strftime("%Y-%m-%d %H:%M:%S")
  vim.api.nvim_put({ "- " .. ts }, "l", true, true)
end, { buffer = true })
