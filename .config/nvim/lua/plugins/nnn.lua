return {
  "mortang2410/nnn.vim",
  lazy = false,
  config = function()
    require("nnn").setup({
      --require my fish shell setup with n.fish command
      command = "n -o -C",
      set_default_mappings = 0,
      replace_netrw = 1,
      action = {
        -- ["<c-t>"] = "tab split",
        -- ["<c-s>"] = "split",
        -- ["<c-v>"] = "vsplit",
        -- ["<c-o>"] = copy_to_clipboard,
      },
    })
  end

}
