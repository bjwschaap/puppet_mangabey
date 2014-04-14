# == Class: puppet_mangabey
#
# Full description of class puppet_mangabey here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class puppet_mangabey (
) inherits puppet_mangabey::params {

  # validate parameters here

  anchor { 'puppet_mangabey::begin': } ->
  class  { '::puppet_mangabey::install': } ->
  class  { '::puppet_mangabey::config': } ~>
  class  { '::puppet_mangabey::service': } ->
  anchor { 'puppet_mangabey::end': }
}
