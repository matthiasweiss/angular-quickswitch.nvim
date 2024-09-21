local M = {}

local file_path_transformations = {
    componentToTemplate = function(path) path:gsub("%.ts$", ".html") end,
    templateToComponent = function(path) path:gsub("%.html$", ".ts") end,
    testToClass = function(path) path:gsub("%.spec%.ts$", ".ts") end,
    classToTest = function(path) path:gsub("%.ts$", ".spec.ts") end,
}

function M.quick_switch_toggle()
    local relative_file_path = vim.fn.expand("%")

    local file_path_transformation_map = {
        { regex = "%.component%.ts$",   transform = file_path_transformations.componentToTemplate },
        { regex = "%.component%.html$", transform = file_path_transformations.templateToComponent },
        { regex = "%.spec%.ts$",        transform = file_path_transformations.testToClass },
        { regex = "%.ts$",              transform = file_path_transformations.classToTest },
    }

    for _, transformation in ipairs(file_path_transformation_map) do
        if string.match(relative_file_path, transformation.regex) then
            local file_to_open = transformation.transform(relative_file_path)
            print(file_to_open)
            vim.cmd.edit(file_to_open)
            return
        end
    end

    error(":NgQuickSwitchToggle could not determine file that should be opened", 1)
end

function M.setup(opts)
    opts = opts or {}

    vim.api.nvim_create_user_command("NgQuickSwitchToggle", M.quick_switch_toggle, {})

    if opts.use_default_keymaps then
        vim.keymap.set("n", "<leader>qs", ":NgQuickSwitchToggle<cr>")
    end
end

return M
