#!/usr/bin/env python
# This will assign Drupal permissions as described at
# https://drupal.org/node/244924
# TODO: check if the owner is a valid user.
# TODO: check to see if www-data is actually the default server user on their
# system.
# TODO: check to see if the path they provide is a valid Drupal install

import argparse
import getpass
import glob
import os
import subprocess
import sys

class DefaultHelpParser(argparse.ArgumentParser):
  """An argument parser that will provide help by default on error."""

  def error(self, message):
    """On error, print out the error message and then the help text."""
    sys.stderr.write('error: %s\n' % message)
    self.print_help()
    sys.exit(2)

def print_and_run(args):
  """Prints a command and runs it."""
  print ' '.join(args)
  subprocess.call(args)

def fix_general_permissions(owner, server_user, drupal_path):
  """Fix the permissions for all files in the root Drupal folder."""
  print_and_run(['sudo', 'chown', '-R', owner + ':' + server_user, drupal_path])
  # there is no shell parsing these commands, so we don't need to worry about
  # the curly braces or semicolon being interpreted by the shell
  print_and_run(['find', drupal_path, '-type', 'd', '-exec', 
                 'chmod', 'u=rwx,g=rx,o=', '{}', ';'])
  print_and_run(['find', drupal_path, '-type', 'f', '-exec', 
                 'chmod', 'u=rw,g=r,o=', '{}', ';'])

def fix_sites_permissions(owner, server_user, drupal_path):
  """Fix the permissions for all files in the sites folder.  Must be in the root
  Drupal folder to start."""
  sites_path = drupal_path + '/sites'
  print_and_run(['find', sites_path, '-type', 'd', '-name', 'files', '-exec', 
                 'chmod', 'ug=rwx,o=', '{}', ';'])
  for directory in glob.iglob(sites_path + '/*/files'):
    print_and_run(['find', directory, '-type', 'd', '-exec',
                   'chmod', 'ug=rwx,o=', '{}', ';'])
    print_and_run(['find', directory, '-type', 'f', '-exec',
                   'chmod', 'ug=rw,o=', '{}', ';'])

def main():
  parser = DefaultHelpParser(
      description='Fix drupal permissions and print out commands as we go',
      formatter_class=argparse.ArgumentDefaultsHelpFormatter)
  parser.add_argument(
      '--owner', default=getpass.getuser(), 
      help='The user to be assigned as the owner. This is probably you. ' + 
           'For security purposes, it should not be the Apache or server ' + 
           'user. If it is not you, you will need to run this as sudo.')
  parser.add_argument(
      '--server-user', default='www-data', 
      help='The username of the web server serving Drupal files. For an ' + 
      'Apache install on Ubuntu, this will be www-data.' ) 
  # required because we don't want to assume that they know what they're doing
  parser.add_argument(
      '--drupal-path', required=True,
      help='The drupal directory where permissions will be fixed. If you ' + 
      'run this script from the drupal directory, you can just use "."') 
  args = parser.parse_args()
  owner = args.owner
  server_user = args.server_user
  drupal_path = args.drupal_path
  fix_general_permissions(owner, server_user, drupal_path)
  fix_sites_permissions(owner, server_user, drupal_path)
  # TODO: fix the permissions in the git directory separately

if __name__ == "__main__":
  main()
