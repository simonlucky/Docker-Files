#!/bin/bash
set -e

# Run custom initialization scripts
if [ -d "/docker-entrypoint-initwp.d" ]; then
  for script in /docker-entrypoint-initwp.d/*; do
    if [ -x "$script" ]; then
      echo "Running $script..."
      "$script"
    else
      echo "Ignoring $script, not executable."
    fi
  done
fi

# Start Apache in the foreground
apachectl -D FOREGROUND


