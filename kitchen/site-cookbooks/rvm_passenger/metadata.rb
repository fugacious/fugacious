maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Installs and configures Passenger under RVM with Apache or nginx"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.8.0"

recipe "rvm_passenger", "Installs Passenger gem with RVM"
recipe "rvm_passenger::apache2", "Enables Apache module configuration for passenger under RVM"
recipe "rvm_passenger::nginx", "Installs Passenger gem w/ RVM, and recompiles support into Nginx"

%w{ rvm nginx apache2 }.each do |cb|
  depends cb
end

%w{ ubuntu }.each do |os|
  supports os
end

attribute "rvm_passenger/version",
  :display_name => "Version of passenger",
  :description => "The version of passenger to deploy. This will be in a format used by the gem command.",
  :default => "3.0.7"

attribute "rvm_passenger/rvm_ruby",
  :display_name => "RVM ruby to use",
  :description => "The RVM ruby (and optional gemset) under which to install the passenger gem. This will be in a format used by the rvm command.",
  :default => "ree-1.8.7-2011.03@passenger"

attribute "rvm_passenger/root_path",
  :display_name => "Root path to passenger gem",
  :description => "Optionally override the full path to the root of the installed passenger gem."

attribute "rvm_passenger/module_path",
  :display_name => "Path to mod_passenger.so",
  :description => "Optionallly override the full path to the Apache2 module."

