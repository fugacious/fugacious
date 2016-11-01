require 'cf-app-utils'

if ENV['VCAP_SERVICES']
  credentials = CF::App::Credentials.find_by_service_name('redis') || {}
  redis = "redis://:#{credentials['password']}@#{credentials['hostname']}:#{credentials['port']}"

  Sidekiq.configure_server do |config|
    config.redis = {url: redis}
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: redis}
  end
end
