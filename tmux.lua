local M = {}

function M.send(cmd)
  local target = vim.g.tmux_target or "right"
  vim.fn.system({ "tmux", "send", "-t", target, "-X", "cancel" })
  vim.fn.system({ "tmux", "send-keys", "-t", target, cmd, "Enter" })
end

return M
