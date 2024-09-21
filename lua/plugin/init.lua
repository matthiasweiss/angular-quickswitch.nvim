local M = {}

local file_path_transformations = {
    unchanged = function(path) return path end,

    componentToTemplate = function(path) return path:gsub("%.ts$", ".html") end,
    templateToComponent = function(path) return path:gsub("%.html$", ".ts") end,

    testToClass = function(path) return path:gsub("%.spec%.ts$", ".ts") end,
    classToTest = function(path) return path:gsub("%.ts$", ".spec.ts") end,

    cssToComponent = function(path) return path:gsub("%.css$", ".ts") end,
    scssToComponent = function(path) return path:gsub("%.scss$", ".ts") end,
    sassToComponent = function(path) return path:gsub("%.sass$", ".ts") end,
    lessToComponent = function(path) return path:gsub("%.less$", ".ts") end,

    testToTemplate = function(path) return path:gsub("%.spec%.ts$", ".html") end,
    cssToTemplate = function(path) return path:gsub("%.css$", ".html") end,
    scssToTemplate = function(path) return path:gsub("%.scss$", ".html") end,
    sassToTemplate = function(path) return path:gsub("%.sass$", ".html") end,
    lessToTemplate = function(path) return path:gsub("%.less$", ".html") end,
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
        { regex = "%.component%.ts$",   transform = file_path_transformations.componentToTemplate },
        { regex = "%.component%.html$", transform = file_path_transformations.templateToComponent },
        { regex = "%.spec%.ts$",        transform = file_path_transformations.testToClass },
        { regex = "%.ts$",              transform = file_path_transformations.classToTest },
    }

    open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchToggle" })
end

function M.quick_switch_component()
    local file_path_transformation_map = {
        { regex = "%.component%.ts$",       transform = file_path_transformations.unchanged },
        { regex = "%.component%.html$",     transform = file_path_transformations.templateToComponent },
        { regex = "%.component%.spec%.ts$", transform = file_path_transformations.testToClass },
        { regex = "%.component%.css$",      transform = file_path_transformations.cssToComponent },
        { regex = "%.component%.scss$",     transform = file_path_transformations.scssToComponent },
        { regex = "%.component%.sass$",     transform = file_path_transformations.sassToComponent },
        { regex = "%.component%.less$",     transform = file_path_transformations.lessToComponent },
    }

    open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchComponent" })
end

function M.quick_switch_template()
    local file_path_transformation_map = {
        { regex = "%.component%.ts$",       transform = file_path_transformations.componentToTemplate },
        { regex = "%.component%.html$",     transform = file_path_transformations.unchanged },
        { regex = "%.component%.spec%.ts$", transform = file_path_transformations.testToTemplate },
        { regex = "%.component%.css$",      transform = file_path_transformations.cssToTemplate },
        { regex = "%.component%.scss$",     transform = file_path_transformations.scssToTemplate },
        { regex = "%.component%.sass$",     transform = file_path_transformations.sassToTemplate },
        { regex = "%.component%.less$",     transform = file_path_transformations.lessToTemplate },
    }

    open_target_file({ file_path_transformation_map = file_path_transformation_map, command = "NgQuickSwitchComponent" })
end

function M.setup(opts)
    opts = opts or {}

    vim.api.nvim_create_user_command("NgQuickSwitchToggle", M.quick_switch_toggle, {})
    vim.api.nvim_create_user_command("NgQuickSwitchComponent", M.quick_switch_component, {})

    if opts.use_default_keymaps then
        vim.keymap.set("n", "<leader>qs", ":NgQuickSwitchToggle<cr>")
    end
end

return M
