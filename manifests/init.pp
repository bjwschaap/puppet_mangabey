# == Class: mangabey
#
# Full description of class mangabey here.
#
# === Parameters
#
# [*proxy_url*]
#  Optional. Proxy url to use for installing RVM, Ruby and Gems.
#
class mangabey(
  $proxy_url = $mangabey::params::proxy_url

) inherits mangabey::params {

  anchor { 'mangabey::begin': } ->
  class  { '::mangabey::install': } ->
  class  { '::mangabey::config': } ~>
  class  { '::mangabey::service': } ->
  anchor { 'mangabey::end': }
}
