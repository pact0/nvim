local lsp = {}
local conf = require("modules.lsp.config")

lsp["RishabhRD/popfix"] = {}
lsp["williamboman/nvim-lsp-installer"] = {config = conf.lsp, opt = true,
  require={"jose-elias-alvarez/nvim-lsp-ts-utils"} }

lsp["ray-x/lsp_signature.nvim"] = {opt = true}

lsp["neovim/nvim-lspconfig"] = {opt = true }

-- lsp["onsails/lspkind-nvim"] = {opt = true}

lsp["RishabhRD/nvim-lsputils"] = {opt = true }

lsp["jose-elias-alvarez/nvim-lsp-ts-utils"] = {opt=true}

return lsp
