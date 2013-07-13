#!/usr/bin/env python
# This will assign Drupal permissions as described at
# https://drupal.org/node/244924

import datetime
import subprocess
import argparse
import os
import sys
import getpass

# fix permissions
# cd /path_to_drupal_installation
# sudo chown -R $OWNER:$WEB_ADMIN .
# find . -type d -exec chmod u=rwx,g=rx,o= '{}' \;
# find . -type f -exec chmod u=rw,g=r,o= '{}' \;

# fix sites permissions
# cd /path_to_drupal_installation/sites
# find . -type d -name files -exec chmod ug=rwx,o= '{}' \;
# for d in ./*/files
# do
#   find $d -type d -exec chmod ug=rwx,o= '{}' \;
#   find $d -type f -exec chmod ug=rw,o= '{}' \;
# done


def main():
  parser = DefaultHelpParser(
      description='Fix drupal permissions',
      formatter_class=argparse.ArgumentDefaultsHelpFormatter)
  parser.add_argument(
      '--owner', default=getpass.getuser(), 
      help='The user to be assigned as the owner.  This is probably you.  ' + 
           'For security purposes, it should not be the Apache or server user')
  parser.add_argument(
      '--server-user', default='www-data', 
      help='The username of the web server serving Drupal files.  For an ' + 
      'Apache install on Ubuntu, this will be www-data.' ) 
  parser.add_argument(
      '--drupal-path', required=True,
      help='The drupal directory where permissions will be fixed.  If you ' + 
      'run this script from the drupal directory, you can just use "."') 
  args = parser.parse_args()
  owner = args.owner
  server_user = args.server_user
  drupal_path = args.drupal_path

class DefaultHelpParser(argparse.ArgumentParser):
  def error(self, message):
    sys.stderr.write('error: %s\n' % message)
    self.print_help()
    sys.exit(2)

if __name__ == "__main__":
  main()
