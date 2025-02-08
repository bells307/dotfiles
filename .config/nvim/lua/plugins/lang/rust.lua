return {
  -- Extend auto completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          completion = {
            cmp = { enabled = true },
          },
        },
      },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "crates" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "rust", "ron" } },
  },

  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "codelldb" } },
  },

  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^5", -- Recommended
  --   ft = { "rust" },
  --   opts = {
  --     dap = {
  --       autoload_configurations = false,
  --     },
  --     server = {
  --       on_attach = function(_, bufnr)
  --         vim.keymap.set("n", "<leader>rd", function()
  --           vim.cmd.RustLsp("debuggables")
  --         end, { desc = "Debuggables", buffer = bufnr })
  --
  --         vim.keymap.set("n", "<leader>rp", function()
  --           vim.cmd.RustLsp("parentModule")
  --         end, { desc = "Parent Module", buffer = bufnr })
  --
  --         vim.keymap.set("n", "<leader>rc", function()
  --           vim.cmd.RustLsp("openCargo")
  --         end, { desc = "Open Cargo.toml", buffer = bufnr })
  --
  --         vim.keymap.set("n", "<leader>rk", function()
  --           vim.cmd.RustLsp({ "moveItem", "up" })
  --         end, { desc = "Move Item Up", buffer = bufnr })
  --
  --         vim.keymap.set("n", "<leader>rj", function()
  --           vim.cmd.RustLsp({ "moveItem", "down" })
  --         end, { desc = "Move Item Down", buffer = bufnr })
  --
  --         vim.keymap.set("n", "<leader>re", function()
  --           vim.cmd.RustLsp("explainError")
  --         end, { desc = "Explain Error", buffer = bufnr })
  --
  --         -- vim.keymap.set("n", "<leader>rd", function()
  --         --   vim.cmd.RustLsp("renderDiagnostic")
  --         -- end, { desc = "Render Diagnostic", buffer = bufnr })
  --         --
  --         -- vim.keymap.set("n", "<leader>rD", function()
  --         --   vim.cmd.RustLsp("relatedDiagnostics")
  --         -- end, { desc = "Related Diagnostics", buffer = bufnr })
  --
  --         vim.keymap.set("n", "<leader>ca", function()
  --           vim.cmd.RustLsp("codeAction")
  --         end, { desc = "Rust Code Action", silent = true, buffer = bufnr })
  --       end,
  --       default_settings = {
  --         ["rust-analyzer"] = {
  --           cargo = {
  --             allFeatures = true,
  --             loadOutDirsFromCheck = true,
  --             buildScripts = {
  --               enable = true,
  --             },
  --           },
  --           checkOnSave = true,
  --           procMacro = {
  --             enable = true,
  --             ignored = {
  --               ["async-trait"] = { "async_trait" },
  --               ["napi-derive"] = { "napi" },
  --               ["async-recursion"] = { "async_recursion" },
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
  --   end,
  -- },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true,
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        taplo = {
          on_attach = function(_, bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "", {
              noremap = true,
              silent = true,
              callback = function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            })
          end,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
      }

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
