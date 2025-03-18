return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- See `:help ibl`
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      require('ibl').setup {
        indent = {
          char = '│',
        },
        scope = {
          enabled = false,
        },
        exclude = {
          filetypes = {
            'help',
            'packer',
            'NvimTree',
            'dashboard',
          },
        },
      }
    end,
  },
}
