return {
  {
    "nvim-neotest/neotest",
    lazy = false,
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-dotnet",
        },
        diagnostic = {
          enabled = true,
          severity = 1,
        },
      }
    end,
  },
  { "nvim-neotest/neotest-plenary", opts = { adapter = "neotest-plenary" } },
  {
    "Issafalcon/neotest-dotnet",
  },
}
