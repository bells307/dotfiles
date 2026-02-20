return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History" },
        { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
    config = function()
        local actions = require("diffview.actions")

        require("diffview").setup({
            diff_binaries = false,
            enhanced_diff_hl = true,
            git_cmd = { "git" },
            hg_cmd = { "hg" },
            use_icons = true,
            show_help_hints = true,
            watch_index = true,

            icons = {
                folder_closed = "",
                folder_open = "",
            },

            signs = {
                fold_closed = "",
                fold_open = "",
                done = "✓",
            },

            view = {
                default = {
                    layout = "diff2_horizontal",
                    disable_diagnostics = false,
                    winbar_info = false,
                },
                merge_tool = {
                    layout = "diff3_horizontal",
                    disable_diagnostics = true,
                    winbar_info = true,
                },
                file_history = {
                    layout = "diff2_horizontal",
                    disable_diagnostics = false,
                    winbar_info = false,
                },
            },

            file_panel = {
                listing_style = "tree",
                tree_options = {
                    flatten_dirs = true,
                    folder_statuses = "only_folded",
                },
                win_config = {
                    position = "left",
                    width = 35,
                },
            },

            file_history_panel = {
                log_options = {
                    git = {
                        single_file = {
                            diff_merges = "combined",
                        },
                        multi_file = {
                            diff_merges = "first-parent",
                        },
                    },
                },
                win_config = {
                    position = "bottom",
                    height = 16,
                },
            },

            commit_log_panel = {
                win_config = {},
            },

            default_args = {
                DiffviewOpen = {},
                DiffviewFileHistory = {},
            },

            hooks = {
                view_opened = function()
                    vim.cmd("wincmd =")
                end,
            },

            keymaps = {
                disable_defaults = false,
                view = {
                    { "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
                    { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
                    { "n", "gf", actions.goto_file_edit, { desc = "Open file" } },
                    { "n", "<leader>e", actions.toggle_files, { desc = "Toggle file panel" } },
                    { "n", "<leader>b", actions.focus_files, { desc = "Focus file panel" } },
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
                },
                file_panel = {
                    { "n", "j", actions.next_entry, { desc = "Next entry" } },
                    { "n", "k", actions.prev_entry, { desc = "Previous entry" } },
                    { "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
                    { "n", "o", actions.select_entry, { desc = "Open diff" } },
                    { "n", "s", actions.toggle_stage_entry, { desc = "Stage/unstage" } },
                    { "n", "S", actions.stage_all, { desc = "Stage all" } },
                    { "n", "U", actions.unstage_all, { desc = "Unstage all" } },
                    { "n", "X", actions.restore_entry, { desc = "Restore entry" } },
                    { "n", "R", actions.refresh_files, { desc = "Refresh" } },
                    { "n", "L", actions.open_commit_log, { desc = "Commit log" } },
                    { "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
                    { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
                    { "n", "gf", actions.goto_file_edit, { desc = "Open file" } },
                    { "n", "<leader>e", actions.toggle_files, { desc = "Toggle panel" } },
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
                },
                file_history_panel = {
                    { "n", "j", actions.next_entry, { desc = "Next entry" } },
                    { "n", "k", actions.prev_entry, { desc = "Previous entry" } },
                    { "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
                    { "n", "o", actions.select_entry, { desc = "Open diff" } },
                    { "n", "!", actions.options, { desc = "Options" } },
                    { "n", "L", actions.open_commit_log, { desc = "Commit log" } },
                    { "n", "y", actions.copy_hash, { desc = "Copy commit hash" } },
                    { "n", "zR", actions.open_all_folds, { desc = "Open all folds" } },
                    { "n", "zM", actions.close_all_folds, { desc = "Close all folds" } },
                    { "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
                    { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
                    { "n", "gf", actions.goto_file_edit, { desc = "Open file" } },
                    { "n", "<leader>e", actions.toggle_files, { desc = "Toggle panel" } },
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
                },
            },
        })
    end,
}
