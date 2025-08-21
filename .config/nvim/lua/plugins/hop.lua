return {
  {
    "smoka7/hop.nvim",
    opts = {},
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["s"] = { function() require("hop").hint_char1() end, desc = "Hop hint char" },
            ["<S-s>"] = { function() require("hop").hint_lines() end, desc = "Hop hint lines" },
          },
          v = {
            ["s"] = { function() require("hop").hint_char1 { extend_visual = true } end, desc = "Hop hint char" },
            ["<S-s>"] = {
              function() require("hop").hint_lines { extend_visual = true } end,
              desc = "Hop hint lines",
            },
          },
        },
      },
    },
  },
  {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    ---    opts = { integrations = { hop = true } },
    ---      },
    ---      }
  },
}
