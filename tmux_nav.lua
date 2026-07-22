-- Window/pane navigation across the nvim/tmux boundary.
--
-- Replaces vim-tmux-navigator. The tmux half no longer forks `ps` on every
-- keypress to guess whether a pane holds vim (~47ms each, and wrong over
-- ssh): nvim marks its own pane with @is_vim on entry (see init.lua) and
-- tmux.conf tests that with a format conditional, which tmux evaluates
-- internally.
--
-- The nvim half is the other direction: move within nvim if there is a split
-- that way, otherwise hand off to tmux.

local M = {}

local panes = { h = "-L", j = "-D", k = "-U", l = "-R" }

local function zoomed()
  local flag = vim.fn.system({ "tmux", "display-message", "-p", "#{window_zoomed_flag}" })
  return vim.trim(flag) == "1"
end

local function handoff(arg)
  if not vim.env.TMUX then return end
  if zoomed() then return end
  vim.fn.system({ "tmux", "select-pane", arg })
end

function M.nav(key)
  local from = vim.fn.winnr()
  vim.cmd("wincmd " .. key)
  if from ~= vim.fn.winnr() then return end
  handoff(panes[key])
end

function M.prev()
  local from = vim.fn.winnr()
  vim.cmd("wincmd p")
  if from ~= vim.fn.winnr() then return end
  handoff("-l")
end

return M
