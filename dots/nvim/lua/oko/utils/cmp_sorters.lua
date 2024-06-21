local M = {}

M.eval = {}

---@class sorters.CmpInfo
---@field deets string
---@field comp? lsp.CompletionItem

---@param e1 cmp.Entry
---@param e2 cmp.Entry
---@param lang string
function M.is_lang_lsp(e1, e2, lang)
  return e1.context.filetype == lang
    and e2.context.filetype == lang
    and e1.source.name == "nvim_lsp"
    and e2.source.name == "nvim_lsp"
end

---@param e1 cmp.Entry
---@param e2 cmp.Entry
---@return sorters.CmpInfo, sorters.CmpInfo
function M.get_infos(e1, e2)
  local info1 = {}
  local info2 = {}

  local c1 = e1:get_completion_item()
  local c2 = e2:get_completion_item()

  info1["comp"] = c1
  info2["comp"] = c2

  -- info1["deets"] =
  info1["deets"] = (c1.labelDetails and (c1.labelDetails.detail or c1.labelDetails.description)) or ""
  info2["deets"] = (c2.labelDetails and (c2.labelDetails.detail or c2.labelDetails.description)) or ""

  return info1, info2
end

function M.eval.bad_bools(is_first_bad, is_second_bad)
  if is_first_bad and not is_second_bad then return false end
  if not is_first_bad and is_second_bad then return true end

  return nil
end

function M.eval.smaller_number_better(first_n, second_n)
  if first_n == nil and second_n == nil then return nil end

  -- First is bad
  if first_n == nil then return false end

  -- Second is bad
  if second_n == nil then return true end

  if first_n ~= second_n then return first_n - second_n < 0 end
end

return M
