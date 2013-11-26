#!/usr/bin/env python
# Saves a mysql database backup into the dropbox backups folder.
# To get a crontab working with this, figure out where the script is and run
#   crontab -e
# and add the following lines:
#   @hourly  python /path/to/this/script/backup-mysql.py --backup-period hourly
#   @daily   python /path/to/this/script/backup-mysql.py --backup-period daily
#   @monthly python /path/to/this/script/backup-mysql.py --backup-period monthly
# Before doing that, you should customize the BACKUP_ROOT variable.
# You should also make a mysql config file called backup-mysql.my.cnf and put it
# in the BACKUP_ROOT.

import datetime
import subprocess
import argparse
import os
import sys

BACKUP_ROOT = '/home/samking/Dropbox/mysql-backups/'
BACKUP_CONFIG_FILE = BACKUP_ROOT + 'backup-mysql.my.cnf'
ALLOWED_PERIODS = ['hourly', 'daily', 'monthly']
MAX_BACKUPS_PER_PERIOD = {
    'hourly' : 24,
    'daily' : 31,
    'monthly' : 12
}

def add_backup(backup_period):
  """Creates a new mysql backup named using the current timestamp as a name.
  @param backup_period [hourly|daily|monthly] -- the frequency of the backup."""
  curr_time = datetime.datetime.utcnow()
  time_str = curr_time.isoformat()
  file_path = BACKUP_ROOT + backup_period + '/' + time_str + '-backup.sql'
  output_file = open(file_path, 'w')
  sql_dump = subprocess.call(
      ['mysqldump', '--defaults-extra-file=' + BACKUP_CONFIG_FILE],
      stdout=output_file)

def remove_extra_backups(backup_period):
  """If there are more backups in the provided period than
  MAX_BACKUPS_PER_PERIOD, this will remove the oldest."""
  backup_dir = BACKUP_ROOT + backup_period
  filenames = os.listdir(backup_dir)
  filenames.sort()
  max_backups = MAX_BACKUPS_PER_PERIOD[backup_period]
  if len(filenames) > max_backups:
    num_to_remove = len(filenames) - max_backups
    filenames_to_remove = filenames[:num_to_remove]
    for filename in filenames_to_remove:
      path = backup_dir + '/' + filename
      os.remove(path)

def check_path():
  """Checks that the backup paths all exist.  If the backup root doesn't exist,
  errors out.  If the subfolders don't exist, makes them."""
  if not os.path.exists(BACKUP_ROOT):
    print 'ERROR: the BACKUP_ROOT doesn\'t exist.  Right now, it\'s:'
    print '  ' + BACKUP_ROOT
    print 'If that looks wrong, you should customize it.'
    sys.exit(1)
  for backup_period in ALLOWED_PERIODS:
    backup_dir = BACKUP_ROOT + backup_period
    if not os.path.exists(backup_dir):
      os.makedirs(backup_dir)

def main():
  parser = argparse.ArgumentParser(
      description='Save mysql backups in: ' + BACKUP_ROOT)
  parser.add_argument('--backup-period', choices=ALLOWED_PERIODS, required=True) 
  args = parser.parse_args()
  backup_period = args.backup_period
  check_path()
  add_backup(backup_period)
  remove_extra_backups(backup_period)

if __name__ == "__main__":
  main()
