function tprint(tbl)
  for index, data in ipairs(tbl) do
    print(index)

    if type(data) == "table" then
      for key, value in pairs(data) do
        print("\t", key, value)
      end
    else
      print(data)
    end
  end
end

local function exists(filename)
  local luv = vim.loop
  local stat = luv.fs_stat(filename)
  return stat and stat.type or false
end

local function is_melos_project()
  return exists("melos.yaml")
end

local function is_pnpm_project()
  return exists("pnpm-lock.yaml")
end

return {
  "br1anchen/git-worktree.nvim",
  branch = "brian/tmp/fix-97",
  after = "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local git_worktree = require("git-worktree")
    local Job = require("plenary.job")

    git_worktree.on_tree_change(function(op, metadata)
      if op == git_worktree.Operations.Create or op == git_worktree.Operations.Switch then
        if is_melos_project() then
          print('Melos project detected, running "melos bs"')
          local melos_bs_job = Job:new({
            command = "melos",
            args = { "bs" },
            cwd = metadata.path,
          })

          melos_bs_job:after_success(vim.schedule_wrap(function()
            print("Melos bootstrap success")
          end))

          melos_bs_job:after_failure(vim.schedule_wrap(function(j)
            print("Melos bootstrap failed: ")
            print(tprint(j:stderr_result()))
          end))

          melos_bs_job:start()
        end

        if is_pnpm_project() then
          print('pnpm project detected, running "pnpm install"')
          local pnpm_install_job = Job:new({
            command = "pnpm",
            args = { "install" },
            cwd = metadata.path,
          })

          pnpm_install_job:after_success(vim.schedule_wrap(function()
            print("pnpm install success")
          end))

          pnpm_install_job:after_failure(vim.schedule_wrap(function(j)
            print("pnpm install failed: ")
            print(tprint(j:stderr_result()))
          end))

          pnpm_install_job:start()
        end
      end
    end)

    require("telescope").load_extension("git_worktree")

    vim.keymap.set("n", "<leader>fwt", function()
      require("telescope").extensions.git_worktree.git_worktrees()
    end, { desc = "Find Git Worktree" })
  end,
}
