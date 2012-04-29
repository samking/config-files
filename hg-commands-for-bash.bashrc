# Handy shell functions and aliases for Mercurial development.
# Source this file in your .bash_profile.
# By Ka-Ping Yee (kpy@google.com)

# Show a compact and nicely coloured graphical changelog.
hgl() {
  hg glog "$@" --template "\x1b[36m{branches}\x1b[0m \x1b[1m{rev}\x1b[0m \x1b[33m{node|short}\x1b[0m \x1b[32m{author|email}\x1b[0m \x1b[31m{date|shortdate}\x1b[0m\n{desc|firstline|fill76|tabindent}\n\n" | \
    expand -t 8,12,16,20,24 | \
    sed -e 's/.\[36m.\[0m //' | \
    sed -e 's/\(.\[32m[a-zA-Z0-9_][a-zA-Z0-9_]*\)@google\.com\(.\[0m\)/\1@\2/' | \
    sed -e 's/\(.\[32m[a-zA-Z0-9_][a-zA-Z0-9_]*\) at google\.com\(.\[0m\)/\1@\2/' | \
    less -R -F -X
}

# Show a compact and nicely coloured log of a selected branch.
#     hgb             # shows the log of the "default" branch.
#     hgb release-7   # shows the log of the "release-7" branch.
hgb() {
  hg log -b "${1:-default}" --template "\x1b[36m{branches}\x1b[0m \x1b[1m{rev}\x1b[0m \x1b[33m{node|short}\x1b[0m \x1b[32m{author|email}\x1b[0m \x1b[31m{date|shortdate}\x1b[0m\n{desc|firstline|fill76|tabindent}\n\n" | \
    expand -t 8,12,16,20,24 | \
    sed -e 's/.\[36m.\[0m //' | \
    sed -e 's/\(.\[32m[a-zA-Z0-9_][a-zA-Z0-9_]*\)@google\.com\(.\[0m\)/\1@\2/' | \
    sed -e 's/\(.\[32m[a-zA-Z0-9_][a-zA-Z0-9_]*\) at google\.com\(.\[0m\)/\1@\2/' | \
    less -R -F -X
}

# Show a compact and nicely coloured list of open branch heads.
hgh() {
  echo
  hg heads -t "$@" --template "\x1b[36m{branches}\x1b[0m \x1b[1m{rev}\x1b[0m \x1b[33m{node|short}\x1b[0m \x1b[32m{author|email}\x1b[0m \x1b[31m{date|shortdate}\x1b[0m\n{desc|firstline|fill76|tabindent}\n\n" | \
    expand -t 8,12,16,20,24 | \
    sed -e 's/.\[36m.\[0m //' | \
    sed -e 's/\(.\[32m[a-zA-Z0-9_][a-zA-Z0-9_]*\)@google\.com\(.\[0m\)/\1@\2/' | \
    sed -e 's/\(.\[32m[a-zA-Z0-9_][a-zA-Z0-9_]*\) at google\.com\(.\[0m\)/\1@\2/'
}

# Clean up any files left over from merges, patches, reversions, or aborted
# runs of Django i18n tools.
hgclean() {
  files=$(find * -name '*.orig' -o -name '*.rej' -o -name '*.pot' -o -name '*.html.py')
  if [ -n "$files" ]; then
    echo $files | perl -pe 's/ /\n/g'
    echo -n "Remove? "
    read answer
    if [ "$answer" == "y" ]; then
      find * \( -name '*.orig' -o -name '*.rej' -o -name '*.pot' -o -name '*.html.py' \) \
        -exec rm {} \;
    fi
  else
    echo "Nothing found to remove."
  fi
}
