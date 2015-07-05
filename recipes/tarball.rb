#
# Cookbook Name:: logstash-ng
# Recipe:: tarball
#
# Copyright 2015, Virender Khatri
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
#

include_recipe 'logstash-ng::user'

[node['logstash']['parent_dir']
].each do |dir|
  directory dir do
    owner node['logstash']['user']
    group node['logstash']['group']
    mode node['logstash']['mode']
    recursive true
  end
end

tarball_file  = ::File.join(node['logstash']['parent_dir'], ::File.basename(node['logstash']['tarball_url']))

# stop logstash service if running for upgrade
service 'logstash' do
  service_name 'logstash'
  action :stop
  only_if { File.exist?('/etc/init.d/logstash') && !File.exist?(node['logstash']['source_dir']) }
end

# download tarball
remote_file tarball_file do
  source node['logstash']['tarball_url']
  checksum node['logstash']['tarball_checksum'][node['logstash']['version']]
  owner node['logstash']['user']
  group node['logstash']['group']
  not_if { File.exist?(::File.join(node['logstash']['source_dir'], 'bin', 'logstash')) }
end

# extract tarball
execute 'extract_logstash_tarball' do
  user node['logstash']['user']
  group node['logstash']['group']
  umask node['logstash']['umask']
  cwd node['logstash']['parent_dir']
  command "tar xzf #{tarball_file}"
  creates ::File.join(node['logstash']['source_dir'], 'bin', 'logstash')
end

remote_file tarball_file do
  action :delete
end

link node['logstash']['install_dir'] do
  to node['logstash']['source_dir']
  owner node['logstash']['user']
  group node['logstash']['group']
  notifies :restart, 'service[logstash]', :delayed if node['logstash']['notify_restart']
  action :create
end

# environment sys config file
template node['logstash']['sysconfig_file'] do
  cookbook node['logstash']['cookbook']
  source 'sysconfig.erb'
  notifies :restart, 'service[logstash]', :delayed if node['logstash']['notify_restart']
end

# sysv init file
template '/etc/init.d/logstash' do
  cookbook node['logstash']['cookbook']
  source 'initd.erb'
  owner 'root'
  group 'root'
  mode 0750
  notifies :restart, 'service[logstash]', :delayed if node['logstash']['notify_restart']
end
