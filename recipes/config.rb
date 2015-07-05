#
# Cookbook Name:: logstash-ng
# Recipe:: config
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

ruby_block 'delayed logstash service start' do
  block do
  end
  notifies :start, 'service[logstash]', :delayed
end

service 'logstash' do
  supports :status => true, :restart => true
  action [:start, :enable]
end
