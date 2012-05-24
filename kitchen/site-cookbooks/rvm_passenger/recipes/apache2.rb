#
# Cookbook Name:: rvm_passenger
# Based on passenger_enterprise
# Recipe:: apache2
#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Author:: Joshua Sierles (<joshua@37signals.com>)
# Author:: Michael Hale (<mikehale@gmail.com>)
#
# Copyright:: 2009, Opscode, Inc
# Copyright:: 2009, 37signals
# Coprighty:: 2009, Michael Hale
# Copyright:: 2010, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "rvm_passenger"
include_recipe "apache2"

# set rvm_passenger/module_path if not set
ruby_block "calculate rvm_passenger/module_path" do
  block do
    node.set[:rvm_passenger][:module_path] =
      "#{node[:rvm_passenger][:root_path]}/ext/apache2/mod_passenger.so"
  end
  only_if do
    node[:rvm_passenger][:module_path].nil?
  end
end

if platform?("suse")
  apache_dev_pkgs = %w{ apache2-devel libapr1-devel libapr-util1-devel }
else
  apache_dev_pkgs = %w{ apache2-threaded-dev libapr1-dev libaprutil1-dev }
end
apache_dev_pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

rvm_shell "passenger_apache2_module" do
  ruby_string   node[:rvm_passenger][:rvm_ruby]
  code          %{passenger-install-apache2-module -a}
  not_if        { ::File.exists? node[:rvm_passenger][:module_path] }
end

template "#{node[:apache][:dir]}/mods-available/passenger.load" do
  source "passenger.load.erb"
  owner "root"
  group "root"
  mode 0755
end

template "#{node[:apache][:dir]}/mods-available/passenger.conf" do
  source "passenger.conf.erb"
  owner "root"
  group "root"
  mode 0755
end

apache_module "passenger"
