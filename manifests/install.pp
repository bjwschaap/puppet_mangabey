# == Class puppet_mangabey::install
#
class puppet_mangabey::install {

  package { $puppet_mangabey::params::package_name:
    ensure => present,
  }
}
