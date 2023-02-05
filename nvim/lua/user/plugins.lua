local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-commentary'

  use 'tpope/vim-surround'

  use 'tpope/vim-eunuch'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-repeat'
  use 'sheerun/vim-polyglot' 
  use 'christoomey/vim-tmux-navigator' 
  use 'farmergreg/vim-lastplace'
  use 'nelstrom/vim-visual-star-search'
  use 'jessarcher/vim-heritage'

  use ({
    'whatyouhide/vim-textobj-xmlattr',
    requires = 'kana/vim-textobj-user'
  })

  
  use({
    'airblade/vim-rooter',
    setup = function()
      vim.g.rooter_manual_only = 1
    end,
    config = function()
      vim.cmd('Rooter')
    end,
  })

  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  })

  use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
 })

  use({
    'jessarcher/onedark.nvim',
    config = function()
      vim.cmd('colorscheme onedark')

      -- Hide the characters in FloatBorder
      vim.api.nvim_set_hl(0, 'FloatBorder', {
        fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
        bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
      })

      -- Make the StatusLineNonText background the same as StatusLine
      vim.api.nvim_set_hl(0, 'StatusLineNonText', {
        fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
        bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
      })

      -- Hide the characters in CursorLineBg
      vim.api.nvim_set_hl(0, 'CursorLineBg', {
        fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
        bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
      })

      vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
    end,
  })

  use({
  'nvim-telescope/telescope.nvim',
   requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
  config = function()
    require('user/plugins/telescope')
  end,
  })  
  
  use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugins.nvim-tree')
  end,
  })

  use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugins.lualine')
  end,
 })

  use({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
    vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
    vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
  end,
 })


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


---

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> 
  augroup end
]])
