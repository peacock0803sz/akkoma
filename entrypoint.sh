#!/usr/bin/env bash

set -e

echo "-- Waiting for database..."
while ! pg_isready -U ${DB_USER} -d postgres://${DB_HOST}:${DB_PORT}/${DB_NAME} -t 1; do
    sleep 1s
done

echo "-- Running migrations..."
mix ecto.migrate

echo "--- Installing pleroma-fe and admin-fe frontends---"
mix pleroma.frontend install pleroma-fe --ref stable
mix pleroma.frontend install admin-fe --ref stable

echo "-- Running server..."
mix phx.server
