-- require('lspkind').init({with_text = true})
-- -- Use ehanced LSP stuff
-- vim.lsp.handlers['textDocument/codeAction'] =
--     require'lsputil.codeAction'.code_action_handler
--
-- -- vim.lsp.handlers['textDocument/references'] =
-- --     require'lsputil.locations'.references_handler
--
-- vim.lsp.handlers['textDocument/definition'] =
--     require'lsputil.locations'.definition_handler
--
-- vim.lsp.handlers['textDocument/declaration'] =
--     require'lsputil.locations'.declaration_handler
--
-- vim.lsp.handlers['textDocument/typeDefinition'] =
--     require'lsputil.locations'.typeDefinition_handler
--
-- vim.lsp.handlers['textDocument/implementation'] =
--     require'lsputil.locations'.implementation_handler
--
-- vim.lsp.handlers['textDocument/documentSymbol'] =
--     require'lsputil.symbols'.document_handler
--
-- vim.lsp.handlers['workspace/symbol'] =
--     require'lsputil.symbols'.workspace_handler

-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--     vim.lsp.with(require('lsp_extensions.workspace.diagnostic').handler,
--                  {signs = {severity_limit = "Error"}})

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, update_in_insert = true})(...)
    pcall(vim.diagnostic.setloclist, {open = false})
end

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover,
                 {border = vim.g.floating_window_border_dark})

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help,
                 {border = vim.g.floating_window_border_dark})
