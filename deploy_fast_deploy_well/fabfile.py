from fabric.api import *

env.use_ssh_config = True

def uptime():
	run('uptime')

'''def deploy():
	run(ssh admin@158.69.80.171)
	local(cd /var/www/html)
	local(git clone git@github.com:WilliamMcCann/twitter-clone-Ian-William.git)

command1 = 'ssh admin@158.69.80.171'

def access_server():
	run(command1)'''
