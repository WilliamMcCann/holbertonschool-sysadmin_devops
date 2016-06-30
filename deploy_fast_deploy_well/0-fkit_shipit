from fabric.api import *
from fabric.context_managers import cd

env.use_ssh_config = True
env.hosts = ('158.69.80.171')

def deploy():
	with cd('/var/www/html/twitter-clone-Ian-William'):
		run('git pull')
