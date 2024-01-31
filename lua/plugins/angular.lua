if true then
  return {}
end

--[[
local lspconfig = require("lspconfig")

-- Function to check if the current directory is an Angular project
local function is_angular_project()
  local angular_json = vim.fn.glob("angular.json")
  return angular_json ~= ""
end

-- Function to setup the Angular Language Server
local function setup_angular_ls()
  lspconfig.angularls.setup({
    -- Configuration for angularls

  })
end

-- reads the package.json file and returns the version of Angular
-- for example: 17.0.0
local function get_angular_version()
  local package_json = vim.fn.glob("package.json")
  local package_json_content = vim.fn.readfile(package_json)
  local angular_version = ""
  for _, line in ipairs(package_json_content) do
    if string.find(line, "angular") then
      angular_version = string.match(line, "%d+.%d+.%d+")
    end
  end
  return angular_version
end

-- Function to setup the Angular Language Server
-- @param angularVersion string The version of Angular
-- It should be in the format: 17.0.0
-- The function installs the LSP angular-language-server with Mason
local function setup_angular_ls(angularVersion)
  return { 
    import = "lazyvim.plugins.extras.lang.angular-language-server@v" .. angularVersion
  }
end

if is_angular_project() then
  local angularVersion = get_angular_version()
  setup_angular_ls(angularVersion)
end

-- Auto command to setup Angular LS when entering an Angular project
--[[ Auto command to setup Angular LS when entering an Angular project
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if is_angular_project() then
      local angularVersion = get_angular_version()
      setup_angular_ls(angularVersion)
    end
  end,
})
]]

