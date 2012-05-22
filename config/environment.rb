# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tmp::Application.initialize!

Tmp::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[tmp.grevi.ch] ",
    :sender_address => %{"tmp notifier" <notifier@grevi.ch},
    :exception_recipients => %w{root@grevi.ch}