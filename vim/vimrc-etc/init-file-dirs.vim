" From http://fak3r.com/geek/howto-have-vim-create-backup-and-tmp-directories/
" Sets the backup directory to ~/.vim/backup/
"      the swap directory to ~/.vim/tmp/
"      the undo directory to ~/.vim/undo/
" Makes those directories if they aren't found
" Since these directories can contain sensitive information (eg, passwords
" embedded in files), they should only be readable by the user, so we set
" permissions to 0700.
function InitFileDirs()
  let separator = "."
  let parent = $HOME .'/' . separator . 'vim/'
  let backup = parent . 'backup/'
  let tmp    = parent . 'tmp/'
  let undo   = parent . 'undo/'
  if exists("*mkdir")
    if !isdirectory(parent)
      call mkdir(parent, "", 0700)
    endif
    if !isdirectory(backup)
      call mkdir(backup, "", 0700)
    endif
    if !isdirectory(tmp)
      call mkdir(tmp, "", 0700)
    endif
    if !isdirectory(undo)
      call mkdir(undo, "", 0700)
    endif
  endif
  let missing_dir = 0
  " ending with // makes it save the file with the full path so that editing two
  " files with the same name in different directories won't cause issues.
  " The ,. at the end means that if we can't access our directories, we'll use
  " the current directory (.).
  if isdirectory(tmp)
    execute 'set backupdir=' . resolve(escape(backup, " ")) . "//"
  else
    let missing_dir = 1
  endif
  if isdirectory(backup)
    execute 'set directory=' . resolve(escape(tmp, " ")) . "//"
  else
    let missing_dir = 1
  endif
  if isdirectory(undo)
    if version >= 703
      execute 'set undodir=' . resolve(escape(undo, " ")) . "//"
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

