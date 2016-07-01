from fabric.api import *
from fabric.context_managers import cd

env.use_ssh_config = True
env.hosts = ('54.173.196.56')

def deploy():
	with cd('/var/www/html'):
		run('git pull')
