#!/bin/bash
# This script sets FS_METHOD in wp-config.php or creates wp-config.php if it doesn't exist

# Define the path to the WordPress installation
WP_PATH="/var/www/html/wordpress"

# Check if wp-config.php exists
if [ ! -f $WP_PATH/wp-config.php ]; then
  echo "wp-config.php not found! Creating a new one."

  # Copy wp-config-sample.php to wp-config.php
  if [ -f $WP_PATH/wp-config-sample.php ]; then
    cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php

    # Set database details in wp-config.php using environment variables
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" $WP_PATH/wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" $WP_PATH/wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" $WP_PATH/wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" $WP_PATH/wp-config.php
  else
    echo "wp-config-sample.php not found! Cannot create wp-config.php."
    exit 1
  fi
fi

# Add FS_METHOD to wp-config.php if it's not already there
if ! grep -q "FS_METHOD" $WP_PATH/wp-config.php; then
  echo "define('FS_METHOD', 'direct');" >> $WP_PATH/wp-config.php
  echo "FS_METHOD set to 'direct' in wp-config.php."
else
  echo "FS_METHOD is already set in wp-config.php."
fi

# Ensure the correct group ownership and permissions
chown -R :www-data $WP_PATH
chmod -R 775 $WP_PATH

echo "Permissions adjusted."

