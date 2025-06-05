local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Open telescope picker with all toggles
function M.open()
	local togglewiz = require("togglewiz")
	local toggles = togglewiz.get_toggles()
	local config = togglewiz.get_config()

	-- Create results table for telescope
	local results = {}
	for _, toggle in ipairs(toggles) do
		local status_icon = toggle.state and config.icons.enabled or config.icons.disabled
		table.insert(results, {
			name = toggle.name,
			display = string.format("%s %s", status_icon, toggle.name),
			state = toggle.state,
		})
	end

	-- Create and open picker
	pickers
		.new({}, {
			prompt_title = "ToggleWiz Features",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.display,
						ordinal = entry.name,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				-- Toggle the selected feature
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					togglewiz.toggle(selection.value.name)

					-- Check if we should reopen Telescope to show updated state
					if not config.close_on_toggle then
						-- Small delay to ensure command execution completes
						vim.defer_fn(function()
							M.open()
						end, 100)
					end
				end)
				return true
			end,
		})
		:find()
end

return M
