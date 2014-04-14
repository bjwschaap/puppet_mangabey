# == Class puppet_mangabey::service
#
# This class is meant to be called from puppet_mangabey
# It ensure the service is running
#
class puppet_mangabey::service {
  include puppet_mangabey::params

  service { $puppet_mangabey::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
