local M = {} -- M stands for module, a naming convention

function M.quick_switch_toggle()
    local relative_file_path = vim.fn.expand("%")

    if string.match(relative_file_path, "%.component%.ts$") then
        local file_to_open = relative_file_path:gsub("%.ts$", ".html")
        vim.cmd.edit(file_to_open)
        return
    end

    if string.match(relative_file_path, "%.component%.html$") then
        local file_to_open = relative_file_path:gsub("%.html$", ".ts")
        vim.cmd.edit(file_to_open)
        return
    end

    error(":NgQuickSwitchToggle can only be called in .component.html and .component.ts files", 1)
end

function M.setup(opts)
    opts = opts or {}

    vim.api.nvim_create_user_command("NgQuickSwitchToggle", M.quick_switch_toggle, {})

    if opts.use_default_keymaps then
        vim.keymap.set("n", "<leader>qs", ":NgQuickSwitchToggle<cr>")
    end
end

return M
