local function lsp_config(_, opts)
  vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    float = { border = "rounded" },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
      end

      local fzf = require("fzf-lua")

      map("gd", vim.lsp.buf.definition, "Go to definition")
      map("gD", vim.lsp.buf.declaration, "Go to declaration")
      map("<leader>fd", fzf.diagnostics_document, "Diagnostics (buffer)")
      map("<leader>fD", fzf.diagnostics_workspace, "Diagnostics (workspace)")
      map("gr", fzf.lsp_references, "Go to references")
      map("gI", fzf.lsp_implementations, "Go to implentations")
      map("gy", fzf.lsp_typedefs, "Type definition")
      map("<leader>cs", fzf.lsp_document_symbols, "Document symbols")
      map("<leader>cS", fzf.lsp_workspace_symbols, "Workspace symbols")
      map("<leader>cc", fzf.lsp_incoming_calls, "Incoming calls")
      map("<leader>cC", fzf.lsp_outgoing_calls, "Outgoing calls")

      map("<leader>cr", vim.lsp.buf.rename, "Rename")
      map("<leader>ca", vim.lsp.buf.code_action, "Code action")
      map("<leader>cl", vim.lsp.codelens.refresh, "CodeLens Refresh")
      map("<leader>cR", vim.lsp.codelens.run, "CodeLens Run")
      map("K", vim.lsp.buf.hover, "Hover Documentation")

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true)
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        end, "Toggle Inlay Hints")
      end
    end,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

  require("mason").setup()

  local ensure_installed = vim.tbl_keys(opts.servers or {})
  vim.list_extend(ensure_installed, {
    "stylua",
    "gopls",
    "pyright",
  })

  require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

  require("mason-lspconfig").setup({
    handlers = {
      function(server_name)
        local server = opts.servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        require("lspconfig")[server_name].setup(server)
      end,
    },
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    config = lsp_config,
  },
}
