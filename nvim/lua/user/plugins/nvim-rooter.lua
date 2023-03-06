require('nvim-rooter').setup {
  rooter_patterns = { '.git', '.hg', '.svn', 'go.mod', 'CMakeLists.txt' },
  trigger_patterns = { '*' },
  manual = false,
}
