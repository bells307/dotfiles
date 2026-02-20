return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"rust",
				"go",
				"lua",
				"vim",
				"vimdoc",
				"gitcommit",
				"git_rebase",
				"diff",
				"nix",
				"toml",
				"yaml",
				"json",
				"jsonc",
				"markdown",
				"markdown_inline",
				"bash",
				"regex",
				"comment",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			-- Disable entire built-in ftplugin mappings to avoid conflicts.
			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
			vim.g.no_plugin_maps = true
		end,
		config = function()
			-- configuration
			require("nvim-treesitter-textobjects").setup({
				select = {
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						-- ['@class.outer'] = '<c-v>', -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true of false
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true,
				},
			})

			-- keymaps
			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "as", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
			end)

			-- move function
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "]F", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "[F", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
			end)

			-- move class
			vim.keymap.set({ "n", "x", "o" }, "]c", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "[c", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "]C", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "[C", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
			end)

			-- swap
			vim.keymap.set("n", "<leader>sa", function()
				require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
			end)
			vim.keymap.set("n", "<leader>sA", function()
				require("nvim-treesitter-textobjects.swap").swap_next("@parameter.outer")
			end)
		end,
	},
}
