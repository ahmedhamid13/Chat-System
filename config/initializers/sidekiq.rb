require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq-scheduler/web'
require 'sidekiq-statistic'

if ENV["REDIS_URL"]
    Sidekiq.configure_client do |config|
        config.redis = { url: ENV["REDIS_URL"], network_timeout: 30 }
    end

    Sidekiq.configure_server do |config|
        config.redis = { url: ENV["REDIS_URL"], network_timeout: 30 }
    end
end
