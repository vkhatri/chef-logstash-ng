default['logstash']['version'] = '1.5.3'

default['elasticsearch']['version_suffix'] = value_for_platform_family(
  'debian' => '',
  'rhel' => '-1'
)

default['logstash']['user'] = 'logstash'
default['logstash']['group'] = 'logstash'
default['logstash']['setup_user'] = true

default['logstash']['service_action'] = [:enable, :start]
default['logstash']['notify_restart'] = true

default['logstash']['install_java'] = false
default['logstash']['install_method'] = 'package' # options: tarball package

default['logstash']['tarball_url'] = "https://download.elastic.co/logstash/logstash/logstash-#{node['logstash']['version']}.tar.gz"
default['logstash']['tarball_checksum']['1.5.1'] = 'a12f91bc87f6cd8f1b481c9e9d0370a650b2c36fdc6a656785ef883cb1002894'
default['logstash']['tarball_checksum']['1.5.2'] = '1d1805d388392a69f5049b35c176186389a7f8bf7347c4528c255edc1f9b0d6a'
default['logstash']['tarball_checksum']['1.5.3'] = 'eb3c366074e561d777348bfe9db3d4d1cccbf2fa8e7406776f500b4ca639c4aa'

default['logstash']['cookbook']     = 'logstash-ng'

default['logstash']['umask']     = '0002'
default['logstash']['mode']     = '0775'
default['logstash']['log_dir']      = '/var/log/logstash'
default['logstash']['conf_dir']     = '/etc/logstash/conf.d'
default['logstash']['work_dir']     = '/tmp/logstash'
default['logstash']['home_dir']     = '/var/lib/logstash'

# for tarball installation
default['logstash']['parent_dir']   = '/usr/local/logstash'
default['logstash']['install_dir']   = ::File.join(node['logstash']['parent_dir'], 'logstash')
default['logstash']['source_dir']    = ::File.join(node['logstash']['parent_dir'], "logstash-#{node['logstash']['version']}")

default['logstash']['sysconfig_file'] = value_for_platform_family(
  %w(rhel fedora) => '/etc/sysconfig/logstash',
  'debian' => '/etc/default/logstash'
)

default['logstash']['base_dir'] = node['logstash']['install_method'] == 'tarball' ? node['logstash']['install_dir'] : '/opt/logstash'
default['logstash']['patterns_dir'] = ::File.join(node['logstash']['base_dir'], 'patterns')

default['logstash']['daemon'] = ::File.join(node['logstash']['base_dir'], 'bin', 'logstash')

default['logstash']['packages'] = []

default['logstash']['sysconfig']['LS_OPTS'] = "-w #{node['cpu']['total']}"
default['logstash']['sysconfig']['LS_JAVA_OPTS'] = '-Djava.io.tmpdir=$HOME'
default['logstash']['sysconfig']['LS_USE_GC_LOGGING'] = false
default['logstash']['sysconfig']['LS_NICE'] = 19
default['logstash']['sysconfig']['LS_OPEN_FILES'] = 16_384

default['logstash']['ssl_home'] = value_for_platform_family(
  'debian' => '/etc/ssl/certs',
  %w(rhel fedora) => '/etc/pki/tls/certs'
)
