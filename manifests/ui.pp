# Class: storm::ui
#
# This module manages storm uiation
#
# Parameters: None
#
# Actions: None
#
# Requires: storm::install
#
# Sample Usage:
#
#  class {'storm::ui': }
#
class storm::ui(
  $actions_enabled     = true,
  $manage_service      = false,
  $enable              = true,
  $filter              = 'null',
  $filter_params       = 'null',
  $force_provider      = undef,
  $header_buffer_bytes = '4096',
  $http_creds_plugin   = 'backtype.storm.security.auth.DefaultHttpCredentialsPlugin',
  $mem                 = '1024m',
  $port                = '8080',
  $host                = '0.0.0.0',
  $childopts           = '-Xmx768m',
  $jvm                 = [
    '-Dlog4j.configuration=file:/etc/storm/storm.log.properties',
    '-Dlogfile.name=ui.log'
  ],
  $config_file         = $storm::config_file,
  $users               = 'null',
  ) inherits storm {
  validate_bool($manage_service)
  validate_array($jvm)

  concat::fragment { 'ui':
    ensure  => present,
    target  => $config_file,
    content => template("${module_name}/storm_ui.erb"),
    order   => 3,
  }

  # Install ui /etc/default
  storm::service { 'ui':
    manage_service => $manage_service,
    force_provider => $force_provider,
    enable         => $enable,
    config_file    => $config_file,
    jvm_memory     => $mem,
    opts           => $jvm,
  }

}
