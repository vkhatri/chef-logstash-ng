logstash-ng Cookbook
==============================

[![Build Status](https://travis-ci.org/vkhatri/chef-logstash-ng.svg?branch=master)](https://travis-ci.org/vkhatri/chef-logstash-ng)

This is a [Chef] cookbook to manage [LogStash] via HWRP.

This cookbook was heavily inspired from logstash cookbook maintained by jsirex.

More features and attributes will be added over time, **feel free to contribute**
what you find missing!

## Repository

https://github.com/vkhatri/chef-logstash-ng


## Supported OS

This cookbook was tested on Amazon (2015-03) & Ubuntu (14.04) Linux and expected to work on similar platform family OS.


## Supported Logstash Version

This cookbook was tested for Logstash v1.5.2+.


## Supported Logstash Deployment

This cookbook supports both Package and Tarball based installation.


## Recipes

- `logstash-ng::default` - default recipe (use it for run_list)

- `logstash-ng::install` - install logstash via package or tarball

- `logstash-ng::java` - install java using `java` cookbook

- `logstash-ng::package` - install logstash using repository package

- `logstash-ng::tarball` - install logstash using tarball

- `logstash-ng::user` - setup user/group for logstash service

- `logstash-ng::config` - configure logstash


## Cookbook Advanced Attributes

* `default['logstash']['install_method']` (default: `package`): logstash install method, options: package tarball

* `default['logstash']['install_java']` (default: `true`): whether to install java using cookbook `java`

* `default['logstash']['service_action']` (default: `[:enable, :start]`): logstash service resource action

* `default['logstash']['notify_restart']` (default: `true`): whether to notify logstash service on any config change

* `default['logstash']['setup_user']` (default: `true`): whether to setup logstash service user when installing via tarball


## Cookbook Core Attributes

* `default['logstash']['version']` (default: `1.5.3`): logstash version to install

* `default['logstash']['version_suffix']` (default: `calculated`): logstash package version suffix

* `default['logstash']['user']` (default: `logstash`): logstash service user

* `default['logstash']['group']` (default: `logstash`): logstash service group

* `default['logstash']['conf_dir']` (default: `/etc/logstash/conf.d`): logstash configuration directory

* `default['logstash']['patterns_dir']` (default: `/etc/logstash/patterns`): logstash patterns directory

* `default['logstash']['log_dir']` (default: `/var/log/logstash`): logstash log directory

* `default['logstash']['work_dir']` (default: `/tmp/logstash`): logstash temporary files directory

* `default['logstash']['home_dir']` (default: `/var/lib/logstash`): logstash home directory

* `default['logstash']['tarball_url']` (default: `calculated`): logstash tarball source url

* `default['logstash']['tarball_checksum']` (default: `versions`): logstash tarball version source sha256sum

* `default['logstash']['parent_dir']` (default: `/usr/local/logstash`): logstash directory for tarball based installation

* `default['logstash']['install_dir']` (default: `/usr/local/logstash/logstash`): logstash symlink to current version source directory (for tarball based installation)

* `default['logstash']['source_dir']` (default: `calculated`): logstash current version directory (for tarball based installation)

* `default['logstash']['sysconfig_file']` (default: `calculated`): logstash service config file location

* `default['logstash']['umask']` (default: `0022`): file/directory umask for execute resource (for tarball based installation)

* `default['logstash']['mode']` (default: `0755`): file/directory resource mode

* `default['logstash']['daemon']` (default: `calculated`): logstash binary location

# Service Attributes

* `default['logstash']['sysconfig']['LS_HEAP_SIZE']` (default: `256m`): logstash heap size

* `default['logstash']['sysconfig']['LS_OPTS']` (default: `nil`): logstash options

* `default['logstash']['sysconfig']['LS_JAVA_OPTS']` (default: `-Djava.io.tmpdir=$HOME`): logstash service java options

* `default['logstash']['sysconfig']['LS_USE_GC_LOGGING']` (default: `false`): logstash service parameter

* `default['logstash']['sysconfig']['LS_NICE']` (default: `unlimited`): logstash service nice value

* `default['logstash']['sysconfig']['LS_OPEN_FILES']` (default: `16_384`): logstash service file ulimit

* `default['logstash']['sysconfig']['LS_DAEMON']` (default: `node['logstash']['daemon']`): logstash service binary location


# Logstash YUM/APT Repository Attributes

* `default['logstash']['repo_version']` (default: `calculated`): logstash repository version

* `default['logstash']['yum']['description']` (default: `calculated`): logstash yum reporitory attribute

* `default['logstash']['yum']['gpgcheck']` (default: `true`): logstash yum reporitory attribute

* `default['logstash']['yum']['enabled']` (default: `true`): logstash yum reporitory attribute

* `default['logstash']['yum']['baseurl']` (default: `calculated`): logstash yum reporitory attribute

* `default['logstash']['yum']['gpgkey']` (default: `https://packages.elasticsearch.org/GPG-KEY-elasticsearch`): logstash yum reporitory attribute

* `default['logstash']['yum']['mirrorlist']` (default: `nil`): logstash yum reporitory attribute

* `default['logstash']['yum']['action']` (default: `:create`): logstash yum reporitory attribute


* `default['logstash']['apt']['description']` (default: `calculated`): logstash apt reporitory attribute

* `default['logstash']['apt']['components']` (default: `['stable', 'main']`): logstash apt reporitory attribute

* `default['logstash']['apt']['uri']` (default: `calculated`): logstash apt reporitory attribute

* `default['logstash']['apt']['key']` (default: `http://packages.elasticsearch.org/GPG-KEY-elasticsearch`): logstash apt reporitory attribute

* `default['logstash']['apt']['action']` (default: `:add`): logstash apt reporitory attribute



## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake & rake knife`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[LogStash]: https://www.elastic.co/products/logstash
[Contributors]: https://github.com/vkhatri/chef-logstash-ng/graphs/contributors
[Chef Supermarket]: https://supermarket.chef.io/cookbooks/logstash-ng
