apt_repository 'dotdeb' do
  uri 'http://packages.dotdeb.org '
  distribution 'jessie'
  deb_src true
  key 'https://www.dotdeb.org/dotdeb.gpg'
end


