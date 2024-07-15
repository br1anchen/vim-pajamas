return {
  {
    "sindrets/winshift.nvim",
    keys = {
      { "<leader>v", group = "Windows" },
      { "<leader>v+", "<C-w>+", desc = "window resize large" },
      { "<leader>v-", "<C-w>-", desc = "window resize small" },
      { "<leader>v<", "<C-w><", desc = "window resize left" },
      { "<leader>v=", "<C-w>=", desc = "window reset size" },
      { "<leader>v>", "<C-w>>", desc = "window resize right" },
      { "<leader>vH", "<cmd>WinShift far_left<cr>", desc = "Move window far left" },
      { "<leader>vJ", "<cmd>WinShift far_down<cr>", desc = "Move window far down" },
      { "<leader>vK", "<cmd>WinShift far_up<cr>", desc = "Move window far up" },
      { "<leader>vL", "<cmd>WinShift far_right<cr>", desc = "Move window far right" },
      { "<leader>vd", "<cmd>close<cr>", desc = "Close window" },
      { "<leader>vh", "<cmd>WinShift left<cr>", desc = "Move window left" },
      { "<leader>vj", "<cmd>WinShift down<cr>", desc = "Move window down" },
      { "<leader>vk", "<cmd>WinShift up<cr>", desc = "Move window up" },
      { "<leader>vl", "<cmd>WinShift right<cr>", desc = "Move window right" },
      { "<leader>vs", "<cmd>split<cr>", desc = "Split window vertical" },
      { "<leader>vv", "<cmd>vsplit<cr>", desc = "Split window horizontal" },
      { "<leader>vx", "<cmd>WinShift swap<cr>", desc = "Swap two windows" },
    },
    config = function()
      require("winshift").setup({
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
          -- These are local options applied to the moving window while it's
          -- being moved. They are unset when you leave Win-Move mode.
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          win_move_mode = {
            ["h"] = "left",
            ["j"] = "down",
            ["k"] = "up",
            ["l"] = "right",
            ["H"] = "far_left",
            ["J"] = "far_down",
            ["K"] = "far_up",
            ["L"] = "far_right",
            ["<left>"] = "left",
            ["<down>"] = "down",
            ["<up>"] = "up",
            ["<right>"] = "right",
            ["<S-left>"] = "far_left",
            ["<S-down>"] = "far_down",
            ["<S-up>"] = "far_up",
            ["<S-right>"] = "far_right",
          },
        },
        ---A function that should prompt the user to select a window.
        ---
        ---The window picker is used to select a window while swapping windows with
        ---`:WinShift swap`.
        ---@return integer? winid # Either the selected window ID, or `nil` to
        ---   indicate that the user cancelled / gave an invalid selection.
        window_picker = function()
          return require("winshift.lib").pick_window({
            -- A string of chars used as identifiers by the window picker.
            picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            filter_rules = {
              -- This table allows you to indicate to the window picker that a window
              -- should be ignored if its buffer matches any of the following criteria.
              cur_win = true, -- Filter out the current window
              floats = true, -- Filter out floating windows
              filetype = {}, -- List of ignored file types
              buftype = {}, -- List of ignored buftypes
              bufname = {}, -- List of vim regex patterns matching ignored buffer names
            },
            ---A function used to filter the list of selectable windows.
            ---@param winids integer[] # The list of selectable window IDs.
            ---@return integer[] filtered # The filtered list of window IDs.
            filter_func = nil,
          })
        end,
      })
    end,
  },
}
