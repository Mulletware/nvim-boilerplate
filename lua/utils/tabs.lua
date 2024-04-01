-- This file refers to "tabs" since these buffers act that way visually,
--   but truly this code deals exclusively with buffers
--
-- Neovim does not allow reordering of tabs after they are created,
--   otherwise it would have been implemented here.
--   There is possibly a solution by storing whichever buffers need to be
--   moved, then reopening and reapplying the unsaved buffer state.
--   But come on.

local M = {}

M.get_tabs = function()
  local tabs = {}

  local i = 1
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf_id].buflisted then
      tabs[i] = buf_id
      i = i + 1
    end
  end

  return tabs
end

M.get_tab_id = function(tabIndex)
  local tabs = M.get_tabs()
  for i, tab in pairs(tabs) do
    if i == tabIndex then
      return tab
    end
  end
end

M.get_tab_index = function(tabId)
  local tabs = M.get_tabs()
  for i, tab in pairs(tabs) do
    if tab == tabId then
      return i
    end
  end
end

M.switch_to_tab = function(n)
  local tabId = M.get_tab_id(n)
  if tabId ~= nil then
    vim.cmd('b' .. tabId)
  end
end

return M
