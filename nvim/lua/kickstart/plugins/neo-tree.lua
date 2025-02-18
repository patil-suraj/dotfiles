-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
 
return {
  { -- File explorer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    lazy = true,
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
      { "<leader>bf", "<cmd>Neotree buffers<CR>", desc = "Toggle Buffers" },
      { "<leader>gs", "<cmd>Neotree git_status<CR>", desc = "Git Status" },
      { "<leader>nf", "<cmd>Neotree reveal<CR>", desc = "Find Current Buffer" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
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
        use_libuv_file_watcher = false,
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
        },
        -- always have the full tree visible
        auto_expand = {
          enabled = true,
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
    },
  }
}
