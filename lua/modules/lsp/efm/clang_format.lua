-- local command = string.format('%s ${INPUT}', "/usr/bin/clang-format")
--
-- return {formatCommand = command, formatStdin = true}

local fs = require 'modules.lsp.efm.efm_helper'
local formatter = 'clang-format'
local command = string.format('%s ${INPUT} echo"aaaa"', fs.executable(formatter))

return {
  formatCommand = command,
  formatStdin = true,
}
