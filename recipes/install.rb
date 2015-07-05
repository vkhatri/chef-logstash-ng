#
# Cookbook Name:: logstash-ng
# Recipe:: install
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

include_recipe 'logstash-ng::java'

[node['logstash']['conf_dir']
].each do |dir|
  directory dir do
    mode node['logstash']['mode']
    recursive true
  end
end

[node['logstash']['log_dir'],
 node['logstash']['home_dir']
].each do |dir|
  directory dir do
    owner node['logstash']['user']
    group node['logstash']['group']
    mode node['logstash']['mode']
    recursive true
  end
end

include_recipe "logstash-ng::#{node['logstash']['install_method']}"
