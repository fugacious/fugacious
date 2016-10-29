if ENV['VCAP_SERVICES']
  services = JSON.parse(ENV['VCAP_SERVICES'])
  credentials = services['redis28'].first['credentials']
  redis = "redis://:#{credentials['password']}@#{credentials['host']}:#{credentials['port']}"

  Sidekiq.configure_server do |config|
    config.redis = {url: redis}
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: redis}
  end

end
