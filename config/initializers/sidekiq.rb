if ENV['VCAP_SERVICES']
  services = JSON.parse(ENV['VCAP_SERVICES'])
  credentials = services['redis32'].first['credentials']
  redis = "redis://:#{credentials['password']}@#{credentials['host']}:#{credentials['port']}"

  Sidekiq.configure_server do |config|
    config.redis = {url: redis}
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: redis}
  end

end

Sidekiq.configure_server do |config|
  schedule_file = "config/sidekiq_schedule.yml"

  if File.exists?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end
