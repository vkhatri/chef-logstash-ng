default['logstash']['repo_version'] = node['logstash']['version'].split('.').take(2).join('.')

default['logstash']['yum']['description'] = "Elastic Logstash #{node['logstash']['repo_version']} repository"
default['logstash']['yum']['gpgcheck'] = true
default['logstash']['yum']['enabled'] = true
default['logstash']['yum']['baseurl'] = "http://packages.elasticsearch.org/logstash/#{node['logstash']['repo_version']}/centos"
default['logstash']['yum']['gpgkey'] = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
default['logstash']['yum']['mirrorlist'] = nil
default['logstash']['yum']['action'] = :create

default['logstash']['apt']['description'] = "Elastic Logstash #{node['logstash']['repo_version']} repository"
default['logstash']['apt']['components'] = %w(stable main)
default['logstash']['apt']['uri'] = "http://packages.elasticsearch.org/logstash/#{node['logstash']['repo_version']}/debian"
default['logstash']['apt']['key'] = 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
default['logstash']['apt']['action'] = :add
