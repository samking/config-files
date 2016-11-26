#!/usr/bin/env bash
sudo apt-get update -y
sudo apt-get install -y apache2 php mysql-server php-mysql php-pear
wget https://github.com/drush-ops/drush/releases/download/8.1.7/drush.phar
chmod +x drush.phar
sudo mv drush.phar /usr/local/bin/drush
drush init
