local opts = function(_, opts)
  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  local cmp = require("cmp")
  local auto_select = true
  local base_opts = {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    auto_brackets = {}, -- configure any filetype to auto add brackets
    completion = {
      completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
    },
    preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<Enter>"] = cmp.mapping.confirm({ select = true }),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
    }),
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
    },
  }

  return vim.tbl_deep_extend("keep", base_opts, opts)
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        opts = {},
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    opts = opts,
  },
}
