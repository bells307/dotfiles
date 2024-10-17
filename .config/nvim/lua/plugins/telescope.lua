return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    opts = {
      {
        defaults = {
          mappings = {
            i = { ["<c-enter>"] = "to_fuzzy_refine" },
            n = {
              ["d"] = "delete_buffer",
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")

      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help Tags" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>f.", function()
        builtin.find_files({ cwd = utils.buffer_dir() })
      end, { desc = "Find Files (Current Buffer directory)" })
      vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "Show Telescope Pickers" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Current Word" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by Grep" })
      vim.keymap.set("n", "<leader>fd", function()
        builtin.diagnostics({ bufnr = 0 })
      end, { desc = "Find Diagnostics (Buffer)" })
      vim.keymap.set("n", "<leader>fD", builtin.diagnostics, { desc = "Find Diagnostics (Workspace)" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Find items from Jumplist" })
      vim.keymap.set("n", "<leader><leader>", function()
        builtin.buffers({ sort_lastused = true, sort_mru = true })
      end, { desc = "Find Existing Buffers" })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>fB", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          -- winblend = 0,
          previewer = false,
        }))
      end, { desc = "Fuzzily Search in Current Buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>fO", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "Live Grep in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>fc", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Find Config files" })
    end,
  },
}
