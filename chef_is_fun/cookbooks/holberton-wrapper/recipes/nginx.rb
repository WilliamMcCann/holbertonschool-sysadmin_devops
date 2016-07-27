package 'nginx@1.10.1'

service 'nginx' do
  supports :status => true
  provider Chef::Provider::Service::Debian
  action [:enable, :start]
end
