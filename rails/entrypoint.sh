#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Wait for the database to be ready
until mysqladmin ping -h db --silent; do
  echo "Waiting for database to be ready..."
  sleep 2
done

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
