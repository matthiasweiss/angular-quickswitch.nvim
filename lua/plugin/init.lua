local M = {}

local file_path_transformations = {
    unchanged = function(path) return path end,

    classToTemplate = function(path) return path:gsub("%.ts$", ".html") end,
    templateToClass = function(path) return path:gsub("%.html$", ".ts") end,

    testToClass = function(path) return path:gsub("%.spec%.ts$", ".ts") end,
    classToTest = function(path) return path:gsub("%.ts$", ".spec.ts") end,

    testToTemplate = function(path) return path:gsub("%.spec%.ts$", ".html") end,

    templateToTest = function(path) return path:gsub("%.html$", ".spec.ts") end,
}

local function open_target_file(opts)
    local relative_file_path = vim.fn.expand("%")

    for _, transformation in ipairs(opts.file_path_transformation_map) do
        if string.match(relative_file_path, transformation.regex) then
            local file_to_open = transformation.transform(relative_file_path)
            vim.cmd.edit(file_to_open)
            return
        end
    end

    error(":" .. opts.command .. " could not determine target file", 1)
end

function M.quick_switch_toggle()
    local file_path_transformation_map = {
        { regex = "%.component%.ts$",   transform = file_path_transformations.classToTemplate },
        { regex = "%.component%.html$", transform = file_path_transformations.templateToClass },
        { regex = "%.spec%.ts$",        transform = file_path_transformations.testToClass },
        { regex = "%.ts$",              transform = file_path_transformations.classToTest },
    }

    open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchToggle" })
end

function M.quick_switch_class()
    local file_path_transformation_map = {
        { regex = "%.ts$",       transform = file_path_transformations.unchanged },
        { regex = "%.html$",     transform = file_path_transformations.templateToClass },
        { regex = "%.spec%.ts$", transform = file_path_transformations.testToClass },
    }

    open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchComponent" })
end

function M.quick_switch_template()
    local file_path_transformation_map = {
        { regex = "%.ts$",       transform = file_path_transformations.classToTemplate },
        { regex = "%.html$",     transform = file_path_transformations.unchanged },
        { regex = "%.spec%.ts$", transform = file_path_transformations.testToTemplate },
    }

    open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchTemplate" })
end

function M.quick_switch_test()
    local file_path_transformation_map = {
        { regex = "%.ts$",       transform = file_path_transformations.classToTest },
        { regex = "%.html$",     transform = file_path_transformations.templateToTest },
        { regex = "%.spec%.ts$", transform = file_path_transformations.unchanged },
    }

    open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchTemplate" })
end

function M.setup(opts)
    opts = opts or {}

    vim.api.nvim_create_user_command("NgQuickSwitchToggle", M.quick_switch_toggle, {})
    vim.api.nvim_create_user_command("NgQuickSwitchComponent", M.quick_switch_class, {})
    vim.api.nvim_create_user_command("NgQuickSwitchTemplate", M.quick_switch_template, {})
    vim.api.nvim_create_user_command("NgQuickSwitchTest", M.quick_switch_test, {})

    if opts.use_default_keymaps then
        vim.keymap.set("n", "<leader>qs", ":NgQuickSwitchToggle<cr>")
    end
end

return M
