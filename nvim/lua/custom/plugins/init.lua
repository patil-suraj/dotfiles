-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      -- Configure Gruvbox Material
      vim.g.gruvbox_material_background = 'medium' -- soft, medium, hard
      vim.g.gruvbox_material_foreground = 'material' -- material, mix, original
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_sign_column_background = 'none'
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      -- Set colorscheme
      vim.o.background = 'dark'
      --vim.cmd 'colorscheme gruvbox-material'
    end,
  },

  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.o.background = 'light'
      vim.g.everforest_better_performance = 1
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme 'everforest'
    end,
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },

  {
    'ThePrimeagen/vim-be-good',
  },
}
