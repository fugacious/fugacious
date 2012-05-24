#
# Cookbook Name:: rvm_passenger
# Based on passenger_enterprise
# Recipe:: nginx
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

include_recipe "nginx::source"
include_recipe "rvm_passenger"

configure_flags = node[:nginx][:configure_flags].join(" ")
nginx_install   = node[:nginx][:install_path]
nginx_version   = node[:nginx][:version]
nginx_dir       = node[:nginx][:dir]
archive_cache   = node[:nginx][:archive_cache] || Chef::Config[:file_cache_path]

remote_file "#{archive_cache}/nginx-#{nginx_version}.tar.gz" do
  source "http://sysoev.ru/nginx/nginx-#{nginx_version}.tar.gz"
  action :create_if_missing
end

bash "extract_nginx_source" do
  cwd archive_cache
  code "tar zxf nginx-#{nginx_version}.tar.gz"
  not_if "test -d #{archive_cache}/nginx-#{nginx_version}"
end

rvm_shell "build passenger_nginx_module" do
  ruby_string   node[:rvm_passenger][:rvm_ruby]
  code          <<-INSTALL
    passenger-install-nginx-module \
      --auto --prefix=#{nginx_install} \
      --nginx-source-dir=#{archive_cache}/nginx-#{nginx_version} \
      --extra-configure-flags='#{configure_flags}'
  INSTALL
  not_if        <<-CHECK
    #{nginx_install}/sbin/nginx -V 2>&1 | \
      grep "`cat /tmp/passenger_root_path`/ext/nginx"
  CHECK
  notifies :restart, resources(:service => "nginx")
end

template "#{nginx_dir}/conf.d/passenger.conf" do
  source "passenger_nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "nginx")
end

# Oh the humanity this should not be required.
file "/tmp/passenger_root_path" do
  action  :delete
end
