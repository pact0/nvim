local wrap_lines = function(input, width)
    local output = {}
    for _, line in ipairs(input) do
        line = line:gsub("\r", "")
        while #line > width + 2 do
            local trimmed_line = string.sub(line, 1, width)
            local index = trimmed_line:reverse():find " "
            if index == nil or index > #trimmed_line / 2 then
                break
            end
            table.insert(output, string.sub(line, 1, width - index))
            line = vim.o.showbreak .. string.sub(line, width - index + 2, #line)
        end
        table.insert(output, line)
    end
    return output
end


local M = {}

local serverity_map = {
    "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint"
}
local icon_map = {"  ", "  ", "  ", "  "}

local function source_string(source) return string.format("  [%s]", source) end

M.line_diagnostics = function()
    local width = 70
    local bufnr, lnum = unpack(vim.fn.getcurpos())
    local diagnostics = vim.lsp.diagnostic.get(bufnr, lnum - 1, {})
    if vim.tbl_isempty(diagnostics) then return end

    local lines = {}

    for _, diagnostic in ipairs(diagnostics) do
        table.insert(lines,
                     icon_map[diagnostic.severity] .. " " ..
                         diagnostic.message:gsub("\n", " ") ..
                         source_string(diagnostic.source))
    end

    local floating_bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(floating_bufnr, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(floating_bufnr, "filetype", "diagnosticpopup")

    for i, diagnostic in ipairs(diagnostics) do
        local message_length = #lines[i] - #source_string(diagnostic.source)
        vim.api.nvim_buf_add_highlight(floating_bufnr, -1,
                                       serverity_map[diagnostic.severity],
                                       i - 1, 0, message_length)
        vim.api.nvim_buf_add_highlight(floating_bufnr, -1, "DiagnosticSource",
                                       i - 1, message_length, -1)
    end

    local winnr = vim.api.nvim_open_win(floating_bufnr, false, {
        relative = "cursor",
        width = width,
        height = #wrap_lines(lines, width - 1),
        row = 1,
        col = 1,
        style = "minimal",
        border = vim.g.floating_window_border_dark
    })

    vim.lsp.util.close_preview_autocmd({
        "CursorMoved", "CursorMovedI", "BufHidden", "BufLeave", "WinScrolled"
    }, winnr)
end

-- diagnostic handling
-- local diagnostic_signs = {' ', ' ', ' ', '𥉉'}
local diagnostic_signs = {"", "", "", ""}
local diagnostic_severity_fullnames = {
    "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint"
}
local diagnostic_severity_shortnames = {'Error', 'Warn', 'Info', 'Hint'}
for index, icon in ipairs(diagnostic_signs) do
    local fullname = diagnostic_severity_fullnames[index]
    local shortname = diagnostic_severity_shortnames[index]

    vim.fn.sign_define('DiagnosticSign' .. shortname, {
        text = icon,
        texthl = 'Diagnostic' .. shortname,
        linehl = '',
        numhl = ''
    })

    vim.fn.sign_define('LspDiagnosticsSign' .. fullname, {
        text = icon,
        texthl = 'LspDiagnosticsSign' .. fullname,
        linehl = '',
        numhl = ''
    })
end
vim.diagnostic.config({
    virtual_text = {prefix = '❰', source = 'if_many', focusable = false}
})

return M
