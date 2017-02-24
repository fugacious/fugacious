if Rails.env.development?
  SecureHeaders::Configuration.default do |config|
    config.csp = SecureHeaders::OPT_OUT # If this line is omitted, we will assume you meant to opt out.
    config.csp_report_only = {
      default_src: %w('self')
    }
  end
else
  SecureHeaders::Configuration.default
end
