-- local fs = require 'efm.efm_helper'
-- local formatter = 'php-cs-fixer'
-- local args = 'fix --no-ansi --using-cache=no --quiet ${INPUT}'
-- local command = string.format('%s %s',
--                               fs.executable(formatter, fs.Scope.COMPOSER), args)
local command =
    '~/.composer/vendor/bin/psalm --output-format=emacs --no-progress'

return {formatCommand = command, formatStdin = false}
