#
# Cookbook Name:: holberton-wrapper
# Recipe:: default
#
# Copyright (C) 2016 William McCann
#
# All rights reserved - Do Not Redistribute
#
#seriously what the heck is going on here
#
#maybe this part configures a user called "holberton" to not be able to log
#in using a password to authenticate, only ssh
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

user_account 'holberton' do
	ssh_keygen true
end
