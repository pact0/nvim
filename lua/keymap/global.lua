local loader = require("packer").loader
local K = {}
local function check_back_space()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.run_or_test = function(debug)
  local ft = vim.bo.filetype
  local fn = vim.fn.expand("%")
  fn = string.lower(fn)
  if fn == "[nvim-lua]" then
    if not packer_plugins["nvim-luadev"].loaded then
      loader("nvim-luadev")
    end
    return t("<Plug>(Luadev-Run)")
  end
  if ft == "lua" then
    local f = string.find(fn, "spec")
    if f == nil then
      -- let run lua test
      return t("<cmd>luafile %<CR>")
    end
    return t("<Plug>PlenaryTestFile")
  end
  if ft == "go" then
    local f = string.find(fn, "test.go")
    if f == nil then
      -- let run lua test
      if debug then
        return t("<cmd>GoDebug <CR>")
      else
        return t("<cmd>GoRun <CR>")
      end
    end

    if debug then
      return t("<cmd>GoDebug nearest<CR>")
    else
      return t("<cmd>GoTestFile <CR>")
    end
  end
end

_G.hop1 = function(ac)
  if packer_plugins["hop"].loaded ~= true then
    loader("hop")
  end
  if vim.fn.mode() == "s" then
    -- print(vim.fn.mode(), vim.fn.mode() == 's')
    return vim.cmd('exe "normal! i s"')
  end
  if ac == 1 then
    require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
  else
    require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
  end
end

_G.Line_ft = function(a)
  if packer_plugins["hop"].loaded ~= true then
    loader("hop")
  end
  if vim.fn.mode() == "s" then
    return vim.fn.input(a)
  end
  -- check and load hop
  local loaded, hop = pcall(require, "hop")
  if not loaded or not hop.initialized then
    require("packer").loader("hop")
    loaded, hop = pcall(require, "hop")
  end
  if a == "f" then
    require("hop").hint_char1({
      direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      current_line_only = true,
      inclusive_jump = true,
    })
  end
  if a == "F" then
    require("hop").hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      current_line_only = true,
      inclusive_jump = true,
    })
  end

  if a == "t" then
    require("hop").hint_char1({
      direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      current_line_only = true,
    })
  end
  if a == "T" then
    require("hop").hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      current_line_only = true,
    })
  end
end

vim.cmd([[command! -nargs=*  DebugOpen lua require"modules.lang.dap".prepare()]])
vim.cmd([[command! -nargs=*  HpoonClear lua require"harpoon.mark".clear_all()]])
