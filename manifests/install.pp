# == Class mangabey::install
#
class mangabey::install(
  $proxy_url = $mangabey::proxy_url
) {

  # Prerequisites for installing RVM
  # (because proxy_url might screw up YUM we 'pre-install these')
  package { [ 'patch',
              'libyaml-devel',
              'libffi-devel',
              'autoconf',
              'automake',
              'libtool',
              'bison']:
    ensure => present,
  } ->
  # Install RVM with Ruby 2.1.1
  class { 'rvm':
    install_dependencies => true,
    system_rubies        => {
      '2.1.1' => {
        'default_use' => true,
        'proxy_url'   => $proxy_url
      }
    }
  } ->
  # Install Mangabey Gem
  rvm_gem { 'mangabey':
    ensure       => present,
    ruby_version => 'ruby-2.1.1',
    proxy_url    => $proxy_url,
  }

}
