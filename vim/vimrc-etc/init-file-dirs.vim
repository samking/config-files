" From http://fak3r.com/geek/howto-have-vim-create-backup-and-tmp-directories/
" Sets the backup directory to ~/.vim/backup/
"      the swap directory to ~/.vim/tmp/
"      the undo directory to ~/.vim/undo/
" Makes those directories if they aren't found
function InitFileDirs()
  let separator = "."
  let parent = $HOME .'/' . separator . 'vim/'
  let backup = parent . 'backup/'
  let tmp    = parent . 'tmp/'
  let undo   = parent . 'undo/'
  if exists("*mkdir")
    if !isdirectory(parent)
      call mkdir(parent)
    endif
    if !isdirectory(backup)
      call mkdir(backup)
    endif
    if !isdirectory(tmp)
      call mkdir(tmp)
    endif
    if !isdirectory(undo)
      call mkdir(undo)
    endif
  endif
  let missing_dir = 0
  " ending with // makes it save the file with the full path so that editing two
  " files with the same name in different directories won't cause issues.
  " The ,. at the end means that if we can't access our directories, we'll use
  " the current directory (.).
  if isdirectory(tmp)
    execute 'set backupdir=' . escape(backup, " ") . "/,."
  else
    let missing_dir = 1
  endif
  if isdirectory(backup)
    execute 'set directory=' . escape(tmp, " ") . "/,."
  else
    let missing_dir = 1
  endif
  if isdirectory(undo)
    if version >= 703
      execute 'set undodir=' . escape(undo, " ") . "/,."
    endif
  else
    let missing_dir = 1
  endif
  if missing_dir
    echo "Warning: Unable to create backup directories: "
    . backup ." and " . tmp
    echo "Try: mkdir -p " . backup
    echo "and: mkdir -p " . tmp
    set backupdir=.
    set directory=.
  endif
endfunction
call InitFileDirs()

