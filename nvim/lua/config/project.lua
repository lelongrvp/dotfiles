-- Detect which project stacks are present in the cwd up front, instead of
-- waiting for a language extra's `ft` autocmd (and its own root_dir search)
-- to fire on the first matching buffer.
local M = {}

local markers = {
  javascript = { "package.json" },
  go = { "go.mod" },
  rust = { "Cargo.toml" },
  python = { "pyproject.toml", "setup.py", "requirements.txt", "Pipfile" },
  ruby = { "Gemfile" },
  php = { "composer.json" },
  java = { "pom.xml", "build.gradle", "build.gradle.kts" },
  dotnet = { "*.csproj", "*.sln" },
  elixir = { "mix.exs" },
  docker = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml" },
  c_cpp = { "CMakeLists.txt", "compile_commands.json" },
}

M.detected = {}

function M.scan()
  local cwd = vim.fn.getcwd()
  local detected = {}
  for kind, patterns in pairs(markers) do
    for _, pattern in ipairs(patterns) do
      if #vim.fn.glob(cwd .. "/" .. pattern, false, true) > 0 then
        detected[kind] = cwd
        break
      end
    end
  end
  M.detected = detected
  return detected
end

vim.api.nvim_create_user_command("ProjectInfo", function()
  if vim.tbl_isempty(M.detected) then
    vim.notify("No known project markers found in " .. vim.fn.getcwd(), vim.log.levels.INFO)
    return
  end
  local lines = {}
  for kind, root in pairs(M.detected) do
    table.insert(lines, kind .. " -> " .. root)
  end
  table.sort(lines)
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Detected project stacks" })
end, {})

return M
