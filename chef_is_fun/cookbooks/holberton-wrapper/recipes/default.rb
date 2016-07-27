#
# Cookbook Name:: holberton-wrapper
# Recipe:: default
#
# Copyright (C) 2016 William McCann
#
# All rights reserved - Do Not Redistribute
#
#

#maybe this installs apt

include_recipe 'dotdeb'

include_recipe 'ntp::default'

include_recipe 'openssh::default'

include_recipe 'holberton_user'

include_recipe 'nginx'

package 'net-tools'








#maybe this part configures a user called "holberton" to not be able to log
#in using a password to authenticate, only ssh

#adds Dotdeb repo to sources.list and installs GnuPG key
file '/etc/apt/sources.list' do
	#run?
	deb http://packages.dotdeb.org jessie all
	deb-src http://packages.dotdeb.org jessie all
	wget https://www.dotdeb.org/dotdeb.gpg
	sudo apt-key add dotdeb.gpg
end

"openssh": {
  "holberton": {
    "password_authentication": "no"
  }
#maybe this line doesn't let you log in as root
"root": {
    "user_known_hosts_file": "/dev/null",
    "strict_host_key_checking": "no"
  }
}

begin
  r = resources(service: 'ssh')
  if 'debian' == node['platform']
    r.provider = Chef::Provider::Service::Debian
  end
end

user_account 'holberton' do
	ssh_keygen true
end

package 'nginx@1.10.1'

service 'nginx' do
  supports :status => true
  action [:enable, :start]
end


#maybe this part installs nginx using package and service
apt_repository 'nginx@1.10.1' do
	uri	'http://packages.dotdeb.org'
end

service 'nginx' do
	action [:enable, :start]
end

#override service
#service 'nginx' do
#  ...
#  provider Chef::Provider::Service::Debian
#  ...
#end

package 'net-tools'
