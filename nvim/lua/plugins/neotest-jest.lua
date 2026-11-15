return {
  "nvim-neotest/neotest",
  dependencies = { "nvim-neotest/neotest-jest" },
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}
    table.insert(
      opts.adapters,
      require("neotest-jest")({
        jestCommand = "pnpm jest",
        cwd = function(path)
          return vim.fs.root(path, "jest.config.js")
            or vim.fs.root(path, "jest.config.ts")
            or vim.fs.root(path, "package.json")
            or vim.fn.getcwd()
        end,
      })
    )
  end,
}
