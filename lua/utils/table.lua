local M = {}

M.table_len = function(table)
  local count = 0
  for _, _ in ipairs(table) do
    count = count + 1
  end
  return count
end

return M
