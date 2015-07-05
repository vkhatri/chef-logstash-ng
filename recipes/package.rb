#
# Cookbook Name:: logstash-ng
# Recipe:: package
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

node['logstash']['packages'].each do |p|
  package p
end

case node['platform_family']
when 'debian'
  # apt repository configuration
  apt_repository 'logstash' do
    uri node['logstash']['apt']['uri']
    components node['logstash']['apt']['components']
    key node['logstash']['apt']['key']
    action node['logstash']['apt']['action']
  end
when 'rhel'
  # yum repository configuration
  yum_repository 'logstash' do
    description node['logstash']['yum']['description']
    baseurl node['logstash']['yum']['baseurl']
    mirrorlist node['logstash']['yum']['mirrorlist']
    gpgcheck node['logstash']['yum']['gpgcheck']
    gpgkey node['logstash']['yum']['gpgkey']
    enabled node['logstash']['yum']['enabled']
    action node['logstash']['yum']['action']
  end
end

# install logstash
package 'logstash' do
  version node['logstash']['version'] + node['elasticsearch']['version_suffix'] if node['platform_family'] == 'rhel'
  notifies :restart, 'service[logstash]', :delayed
end
