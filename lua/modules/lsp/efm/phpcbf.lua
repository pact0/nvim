local fs = require 'modules.lsp.efm.efm_helper'

local formatter = 'phpcbf'
-- local command = string.format('%s -',
--                               fs.executable(formatter, fs.Scope.COMPOSER))
local command = "~/.composer/vendor/bin/phpcbf "

return {formatCommand = command, formatStdin = true}
