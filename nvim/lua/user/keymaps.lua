-- How to find mappings?
-- :nmap - all of the mappings for normal mode 
-- :nmap <leader> - that will be all of my leader mappings
-- :verbose nmap <leader> that will even show me where is my mappings
-- :Telescope keymap - the best way
-- 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- Disable annoying command line thing
vim.keymap.set('n', 'q:', ':q<CR>')

-- Paste replace visual selection without copying it
vim.keymap.set('v', 'p', '"_dP')

vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>')

-- Open the current file in the default program (on Mac this should just be just `open`)
vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>')


-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- debugging
vim.keymap.set("n", "<F5>", require('dap').continue)
vim.keymap.set("n", "<leader>n", require('dap').step_over)
vim.keymap.set("n", "<leader>i", require('dap').step_into)
vim.keymap.set("n", "<leader>o", require('dap').step_out)
vim.keymap.set("n", "<leader>b", require('dap').toggle_breakpoint)

