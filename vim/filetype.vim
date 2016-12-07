augroup filetypedetect
  au BufRead,BufNewFile *.rb setfiletype ruby
  au BufRead,BufNewFile *.HTML setfiletype html
  au BufRead,BufNewFile *.php setfiletype php
  au BufRead,BufNewFile *.c setfiletype c
  au BufRead,BufNewFile *.md set filetype=markdown
augroup END
