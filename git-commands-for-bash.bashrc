# Handy shell aliases for Git
# By Sam King <sam@samking.org>
# Modified from Mercurial scripts by Ka-Ping Yee <kpy@google.com> 
# (available in in hg-commands-for-bash.bashrc) 
# NOTE: This is a shell alias, so it should not be sourced in any type of git
# file.  It should be sourced in your shell config file (you can see how this
# file is sourced in the zshrc).

gitl() {
  # TODO: right now, this truncates long lines (because git passes -FXRS to
  # less).  That's annoying.  However, setting 
  #   git config --global core.pager 'less -r' 
  # means that git doesn't know about control characters, which messes up
  # formatting (eg, the first line might be the third line, and you need to
  # scroll to get it to update).
  # Also, even if we let less do wrapping for us, that would mess up the graph.
  # TODO: In git version 1.8.3, there is a %C(auto) feature.  This lets you
  # specify the colors in the git config, and it lets you get automatic
  # colorization of different branches for the %d flag.  Once the default
  # version of git is updated, add it in.  This is detailed at
  # http://stackoverflow.com/questions/5889878/color-in-git-log

  # hash = %H
  # email = %ae
  # date = %ad
  # branch reference = %d
  # line break = %n
  # subject (one line commit) = %s
  # body (full commit) = %b
  # Set color to color = %Ccolor or %C(color) -- format depends on which color
  # Reset color = %Creset
  FORMAT='%C(yellow)%H%Creset %Cgreen%ae%Creset %Cblue%ad%Creset'
  FORMAT=$FORMAT'%C(cyan)%d%Creset%n%s%n  %b'
  git log --date=short --graph "$@" --format=$FORMAT
}
