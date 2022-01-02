require "sidekiq"
require "sidekiq-cron"
require "sidekiq-scheduler"
require "sidekiq-statistic"
require "sidekiq/web"
require "sidekiq-scheduler/web"
require "sidekiq/cron/web"

if ENV["REDIS_URL"]
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDIS_URL"], network_timeout: 30 }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV["REDIS_URL"], network_timeout: 30 }
  end

  schedule_file = "config/schedule.yml"

  if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end
