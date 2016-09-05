# Class: storm::logviewer
#
# This module manages storm logviewer
#
# Requires: storm:install
#
# Sample Usage:
#
#  class{'storm::logviewer': }
#
class storm::logviewer(
  $manage_service                  = false,
  $enable                          = true,
  $ensure_service                  = 'running',
  $force_provider                  = undef,
  $port                            = 8000,
  $childopts                       = '-Xmx128m',
  $mem                             = '128m',
  $jvm                             = [],
  $config_file                     = $storm::config_file
) inherits storm {

  concat::fragment { 'logviewer':
    ensure  => present,
    target  => $config_file,
    content => template("${module_name}/storm_logviewer.erb"),
    order   => 4,
  }

  storm::service { 'logviewer':
    ensure_service => $ensure_service,
    manage_service => $manage_service,
    force_provider => $force_provider,
    enable         => $enable,
    config_file    => $config_file,
    jvm_memory     => $mem,
    opts           => $jvm,
  }

}