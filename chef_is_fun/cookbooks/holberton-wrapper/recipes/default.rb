#
# Cookbook Name:: holberton-wrapper
# Recipe:: default
#
# Copyright (C) 2016 William McCann
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe 'dotdeb'

include_recipe 'ntp::default'

file /var/run/sshd

node.default['openssh']['server']['permit_root_login'] = 'no'
node.default['openssh']['server']['password_authentication'] = 'no'

include_recipe 'holberton_user'

include_recipe 'nginx'

package 'net-tools'
