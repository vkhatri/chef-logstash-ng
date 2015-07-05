name 'logstash-ng'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures logstash-ng'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.1'

%w(java yum apt).each do |d|
  depends d
end

%w(ubuntu centos redhat fedora amazon).each do |os|
  supports os
end
