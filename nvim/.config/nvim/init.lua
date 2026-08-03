-- ----------------------------
-- Basic Neovim settings
-- ----------------------------

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.confirm = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  extends = ">",
  precedes = "<",
}

-- Clear search highlight with Esc Esc
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>")

-- Save with Ctrl-s
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>a")

-- Short alias: :C to change colorscheme
vim.api.nvim_create_user_command("C", function(opts)
  vim.cmd.colorscheme(opts.args)
end, {
  nargs = 1,
  complete = "color",
})

-- ----------------------------
-- Bootstrap lazy.nvim
-- ----------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- ----------------------------
-- Plugins
-- ----------------------------

require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        bg = "#1f1f28",
        fg = "#dcd7ba",
        blue = "#7e9cd8",
        aqua = "#7aa89f",
        green = "#98bb6c",
        yellow = "#e6c384",
        red = "#e46876",
        muted = "#727169",
        surface = "#2a2a37",
      }

      local kanagawa = {
        normal = {
          a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
          b = { bg = colors.surface, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.muted },
        },
        insert = {
          a = { bg = colors.green, fg = colors.bg, gui = "bold" },
          b = { bg = colors.surface, fg = colors.fg },
        },
        visual = {
          a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
          b = { bg = colors.surface, fg = colors.fg },
        },
        replace = {
          a = { bg = colors.red, fg = colors.bg, gui = "bold" },
          b = { bg = colors.surface, fg = colors.fg },
        },
        command = {
          a = { bg = colors.aqua, fg = colors.bg, gui = "bold" },
          b = { bg = colors.surface, fg = colors.fg },
        },
        inactive = {
          a = { bg = colors.bg, fg = colors.muted, gui = "bold" },
          b = { bg = colors.bg, fg = colors.muted },
          c = { bg = colors.bg, fg = colors.muted },
        },
      }

      require("lualine").setup({
        options = {
          theme = kanagawa,
          globalstatus = true,
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = { modified = " [+]", readonly = " [ro]" },
            },
          },
          lualine_x = { "diagnostics", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },

  -- Better syntax highlighting for code
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      configs.setup({
        ensure_installed = {
          "bash",
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("wincmd _")
    vim.cmd("startinsert")
  end,
})

-- Pick your default theme
vim.cmd.colorscheme("kanagawa")

-- Let Ghostty's transparent background show through Neovim.
local transparent_groups = {
  "Normal",
  "NormalNC",
  "SignColumn",
  "FoldColumn",
  "EndOfBuffer",
  "MsgArea",
  "NormalFloat",
  "FloatBorder",
}

local function set_transparent_background()
  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_transparent_background,
})
set_transparent_background()
