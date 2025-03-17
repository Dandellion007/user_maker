#!/bin/bash
set -e

if [ -z $APP_ENV ]; then
  echo "Environment: $RAILS_ENV"
else
  echo "Environment: $APP_ENV"
fi

# Remove a potentially pre-existing server.pid for Rails.
if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

bundle exec rails server -p 3000 -b 0.0.0.0
