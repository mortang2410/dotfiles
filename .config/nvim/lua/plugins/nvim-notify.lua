return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup {
      timeout = 1000,
      top_down = false,
    }
  end,
}
