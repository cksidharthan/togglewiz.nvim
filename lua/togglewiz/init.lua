local M = {}

-- Default configuration
local defaults = {
	toggles = {},
	icons = {
		enabled = "✓",
		disabled = "✗",
	},
	close_on_toggle = false, 
}

local config = {}

-- Setup function
function M.setup(opts)
	config = vim.tbl_deep_extend("force", defaults, opts or {})

	-- Create user command
	vim.api.nvim_create_user_command("ToggleWiz", function()
		require("togglewiz.telescope").open()
	end, {})
end

-- Execute a command safely
local function execute_command(cmd)
	if type(cmd) == "function" then
		cmd()
	elseif cmd:sub(1, 4) == "lua " then
		local lua_cmd = cmd:sub(5)
		-- Using load instead of deprecated loadstring
		local fn, err = load(lua_cmd)
		if fn then
			fn()
		else
			vim.notify("Error executing command: " .. err, vim.log.levels.ERROR)
		end
	else
		vim.cmd(cmd)
	end
end

-- Toggle a feature by name
function M.toggle(name)
	for i, toggle in ipairs(config.toggles) do
		if toggle.name == name then
			toggle.state = not toggle.state

			if toggle.state then
				execute_command(toggle.enable_cmd)
				vim.notify("Enabled " .. toggle.name, vim.log.levels.INFO)
			else
				execute_command(toggle.disable_cmd)
				vim.notify("Disabled " .. toggle.name, vim.log.levels.INFO)
			end

			return
		end
	end

	vim.notify("Toggle not found: " .. name, vim.log.levels.ERROR)
end

-- Get toggle status icon
function M.get_status_icon(name)
	for _, toggle in ipairs(config.toggles) do
		if toggle.name == name then
			return toggle.state and config.icons.enabled or config.icons.disabled
		end
	end
	return " "
end

-- Get all toggles
function M.get_toggles()
	return config.toggles
end

-- Get config
function M.get_config()
	return config
end

return M
