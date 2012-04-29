" From http://fak3r.com/geek/howto-have-vim-create-backup-and-tmp-directories/
" Sets the backup directory to ~/.vim/backup and the swap directory to
" ~/.vim/tmp//
" Makes those directories if they aren't found
function InitBackupDir()
  let separator = "."
  let parent = $HOME .'/' . separator . 'vim/'
  let backup = parent . 'backup/'
  let tmp    = parent . 'tmp/'
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
  endif
  let missing_dir = 0
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
  if missing_dir
    echo "Warning: Unable to create backup directories: "
    . backup ." and " . tmp
    echo "Try: mkdir -p " . backup
    echo "and: mkdir -p " . tmp
    set backupdir=.
    set directory=.
  endif
endfunction
call InitBackupDir()

