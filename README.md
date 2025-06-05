# ToggleWiz

A simple, powerful Neovim plugin for toggling features with Telescope integration.

![ToggleWiz Demo](https://i.imgur.com/placeholder.gif)

## Features

- **Toggle Neovim Features**: Easily enable/disable various Neovim features and plugins
- **Telescope Integration**: Fuzzy-find and toggle features with Telescope's powerful UI
- **Customizable Icons**: Set your preferred icons for enabled and disabled states
- **Simple Configuration**: Easy setup with sensible defaults
- **Status Indicators**: Visual indicators showing whether features are enabled or disabled
- **Auto Refresh**: The UI refreshes after toggling to show the current state

## Installation

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'cksidharthan/togglewiz.nvim',
  requires = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('togglewiz').setup({
      -- your configuration here
    })
  end
}
```

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'cksidharthan/togglewiz.nvim',
  dependencies = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('togglewiz').setup({
      -- your configuration here
    })
  end
}
```

## Configuration

### Default Configuration

```lua
require('togglewiz').setup({
  toggles = {
    -- Your toggleable features go here
  },
  icons = {
    enabled = "✓",  -- Icon for enabled features
    disabled = "✗"  -- Icon for disabled features
  }
})
```

### Available Options

| Option    | Type  | Default | Description                                                                                        |
| --------- | ----- | ------- | -------------------------------------------------------------------------------------------------- |
| `toggles` | table | {}      | A table of toggles to be added to the UI. See [Toggles](#toggles) for more details.                |
| `icons`   | table | {}      | A table of icons to be used for enabled and disabled states. See [Icons](#icons) for more details. |

## Toggles

Toggles are the individual features that can be toggled. They are defined as a table with the following keys:

| Key         | Type            | Description                                      |
| ----------- | --------------- | ------------------------------------------------ |
| name        | string          | Display name of the feature                      |
| enable_cmd  | string/function | Command to enable the feature                    |
| disable_cmd | string/function | Command to disable the feature                   |
| state       | boolean         | Initial state (true = enabled, false = disabled) |

## Icons

Icons are used to display the current state of a toggle. They are defined as a table with the following keys:

| Key         | Type            | Description                                      |
| ----------- | --------------- | ------------------------------------------------ |
| enabled     | string          | Icon to display when the feature is enabled      |
| disabled    | string          | Icon to display when the feature is disabled     |

## Example Configuration

```lua
require('togglewiz').setup({
  toggles = {
    {
      name = "Copilot",
      enable_cmd = "Copilot enable",
      disable_cmd = "Copilot disable",
      state = true -- Initially enabled
    },
    {
      name = "LSP",
      enable_cmd = "LspStart",
      disable_cmd = "LspStop",
      state = false -- Initially disabled
    },
    {
      name = "Treesitter",
      enable_cmd = "TSEnable",
      disable_cmd = "TSDisable",
      state = true -- Initially enabled
    },
    {
      name = "Diagnostics",
      enable_cmd = "lua vim.diagnostic.enable()",
      disable_cmd = "lua vim.diagnostic.disable()",
      state = true
    },
    {
      name = "Formatting",
      enable_cmd = "lua vim.g.format_on_save = true",
      disable_cmd = "lua vim.g.format_on_save = false",
      state = false
    }
  },
  icons = {
    enabled = "✅",  -- Custom icon for enabled features
    disabled = "❌"  -- Custom icon for disabled features
  }
})
```

## Usage
### Commands
- :ToggleWiz - Open the Telescope picker with all toggleable features

### Workflow
- Run :ToggleWiz to open the feature picker
- Use Telescope's search to find the feature you want to toggle
- Press Enter to toggle the selected feature
- The Telescope UI will refresh to show the updated state

## API
### If you want to toggle features programmatically:
```lua
-- Toggle a feature by name
require('togglewiz').toggle("Copilot")

-- Get current toggles
local toggles = require('togglewiz').get_toggles()

-- Get status icon for a feature
local icon = require('togglewiz').get_status_icon("Copilot")
```

## Creating Keymaps
```lua
-- Add keymaps for common toggles
vim.keymap.set('n', '<leader>tc', function() require('togglewiz').toggle("Copilot") end, { desc = "Toggle Copilot" })
vim.keymap.set('n', '<leader>tl', function() require('togglewiz').toggle("LSP") end, { desc = "Toggle LSP" })
vim.keymap.set('n', '<leader>td', function() require('togglewiz').toggle("Diagnostics") end, { desc = "Toggle Diagnostics" })
```

## Dependencies
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
MIT 

ToggleWiz - Developed with ❤️ for the Neovim community.
