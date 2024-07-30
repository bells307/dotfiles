return {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local everforest = require("everforest")
    everforest.setup({
      background = "soft",
    })
    everforest.setup()
    everforest.load()
  end,
}
