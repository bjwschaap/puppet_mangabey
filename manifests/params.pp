# == Class puppet_mangabey::params
#
# This class is meant to be called from puppet_mangabey
# It sets variables according to platform
#
class puppet_mangabey::params {
  case $::osfamily {
    'RedHat': {
      $package_name = 'puppet_mangabey'
      $service_name = 'puppet_mangabey'
    }
    default: {
      fail("${::operatingsystem} (${::osfamily}) not supported")
    }
  }
}
