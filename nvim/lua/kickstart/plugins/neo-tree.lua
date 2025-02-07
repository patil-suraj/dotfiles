-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
 
return {
  { -- File explorer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
        window = {
          width = 30,
          mappings = {
            ["<space>"] = "none",
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
        },
      })
      
      -- Keymaps
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {})
      vim.keymap.set('n', '<leader>bf', ':Neotree buffers<CR>', {})
      vim.keymap.set('n', '<leader>gs', ':Neotree git_status<CR>', {})
    end,
  }
}
