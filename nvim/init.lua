require 'user.imports'
require('impatient')

require 'user.general'
require 'user.colemak'
require 'user.keymaps'

require 'user.comments'
require 'user.git'
require 'user.indentation'
require 'user.lsp'
require 'user.auto_complete'
require 'user.treesitter'

require 'user.lualine'
require 'user.aesthetics'
-- require 'user.noice'

require('leap').add_default_mappings()

-- TODO: Not currently using this/these -- but someday
local lfs = require("lfs")

local function has_file_extension(dir, extension)
    for file in lfs.dir(dir) do
        if file ~= "." and file ~= ".." then
            local full_path = dir .. "/" .. file
            local mode = lfs.attributes(full_path, "mode")
            if mode == "directory" then
                local has_ext = has_file_extension(full_path, extension)
                if has_ext then
                    return true
                end
            elseif string.match(file, extension .. "$") then
                return true
            end
        end
    end
    return false
end

local current_dir = vim.fn.getcwd()

if has_file_extension(current_dir, ".rs") then
    require "user.rust"
    vim.notify('Rust files detected.')
end

if has_file_extension(current_dir, ".go") then
    require "user.go"
    vim.notify('Go files detected.')
end

if has_file_extension(current_dir, ".py") then
    require "user.python"
    vim.notify('Python files detected.')
end

if has_file_extension(current_dir, ".lua") then
    require 'user.lua'
    vim.notify('luafiles detected.')
end
