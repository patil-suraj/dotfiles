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
      vim.cmd 'colorscheme gruvbox-material'
    end,
  },
}
