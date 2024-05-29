-- This file refers to "buffers" since these buffers act that way visually,
--   but truly this code deals exclusively with buffers
--
-- Neovim does not allow reordering of buffers after they are created,
--   otherwise it would have been implemented here.
--   There is possibly a solution by storing whichever buffers need to be
--   moved, then reopening and reapplying the unsaved buffer state.
--   But come on.

local M = {}

---@return number[]
M.get_buffers = function()
  local buffers = {}

  local i = 1
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf_id].buflisted then
      buffers[i] = buf_id
      i = i + 1
    end
  end

  return buffers
end

---@param tabIndex number
---@return number
M.get_tab_id = function(tabIndex)
  local buffers = M.get_buffers()
  for i, tab in pairs(buffers) do
    if i == tabIndex then
      return tab
    end
  end
end

---@param tabId number
---@return number | nil
M.get_tab_index = function(tabId)
  local buffers = M.get_buffers()
  for i, tab in pairs(buffers) do
    if tab == tabId then
      return i
    end
  end
  return nil
end

---@param n number
---@return nil
M.switch_to_tab = function(n)
  local tabId = M.get_tab_id(n)
  if tabId ~= nil then
    vim.cmd('b' .. tabId)
  end
end

return M
