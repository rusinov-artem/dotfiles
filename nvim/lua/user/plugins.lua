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

use {
    'notjedi/nvim-rooter.lua',
    config = function()
      require('user.plugins.nvim-rooter')
    end
}

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

-- One Dark theme.
use { "catppuccin/nvim", as = "catppuccin" }

  use({
  'nvim-telescope/telescope.nvim',
   requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
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

 use({
  'voldikss/vim-floaterm',
  config = function()
    require('user.plugins.floaterm')
  end,
})

  use({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  requires = {
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('user.plugins.treesitter')
  end,
})
  
  use({
  'neovim/nvim-lspconfig',

  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  
  config = function()
    require('user.plugins.lspconfig')
  end,
})
  

  use({
  'hrsh7th/nvim-cmp',
  requires = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'jessarcher/cmp-path',
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    require('user.plugins.cmp')
  end,
})

-- PHP Refactoring Tools
use({
  'phpactor/phpactor',
  ft = 'php',
  run = 'composer install --no-dev --optimize-autoloader',
  config = function()
    vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
    vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
  end,
})

 use({ "mfussenegger/nvim-dap", requires = { "rcarriga/nvim-dap-ui" },
     config = function ()
       require('user.plugins.go-dap')
     end
   })
 use 'theHamsta/nvim-dap-virtual-text'
 use 'nvim-telescope/telescope-dap.nvim'

 use {"sakhnik/nvim-gdb",  run =  './install.sh' }

  use { 'nagy135/typebreak.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
          vim.keymap.set('n', '<leader>tb', require('typebreak').start, { desc = "Typebreak" })
      end
  }



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
