require('nvim-rooter').setup {
  rooter_patterns = { '.git', '.hg', '.svn', 'go.mod' },
  trigger_patterns = { '*' },
  manual = false,
}
