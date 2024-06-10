local M = {} -- M stands for module, a naming convention

-- https://stackoverflow.com/questions/72921364/whats-the-lua-equivalent-of-pythons-endswith
function string:endswith(suffix)
    ---@diagnostic disable-next-line: param-type-mismatch
    return self:sub(- #suffix) == suffix
end

function M.quick_switch_toggle()
    local relative_file_path = vim.fn.expand("%")
    if relative_file_path:endswith ".ts" then
        local file_to_open = relative_file_path:gsub(".ts$", ".html")
        vim.cmd.edit(file_to_open)
        return
    end

    if relative_file_path:endswith ".html" then
        local file_to_open = relative_file_path:gsub(".html$", ".ts")
        vim.cmd.edit(file_to_open)
        return
    end

    print("NgQuickSwitchToggle command can only be used to toggle between .ts and .html")
end

function M.setup()
    vim.api.nvim_create_user_command("NgQuickSwitchToggle", M.quick_switch_toggle, {})
    vim.keymap.set("n", "<leader>uu", ":NgQuickSwitchToggle<cr>")
end

return M
