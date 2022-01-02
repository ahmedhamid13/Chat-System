#!/bin/bash

# Wait for DB services
sh ./config/docker/wait-for-services.sh

# Run Workers (Sidekiq)
# sh ./config/docker/run-sidekiq.sh

# Prepare DB (Migrate - If not? Create db & Migrate)
sh ./config/docker/prepare-db.sh

# Start Application
bundle exec puma -C config/puma.rb