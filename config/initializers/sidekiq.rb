require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq-statistic'

if ENV["REDISTOGO_URL"]
    Sidekiq.configure_client do |config|
        config.redis = { url: ENV["REDISTOGO_URL"], network_timeout: 30 }
    end

    Sidekiq.configure_server do |config|
        config.redis = { url: ENV["REDISTOGO_URL"], network_timeout: 30 }
    end
end
