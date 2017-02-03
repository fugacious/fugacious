SecureHeaders::Configuration.default do |config|
  config.csp = config.csp.merge(script_src: %w('self'))
end
