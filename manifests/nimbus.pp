# Class: storm::nimbus
#
# This module manages storm nimbusation
#
#
# Requires: storm::install
#
# Sample Usage:
#  class {'storm::nimbus': }
#
class storm::nimbus(
  $manage_service                = false,
  $enable                        = true,
  $ensure_service                = 'running',
  $force_provider                = undef,
  $mem                           = '1024m',
  $host                          = 'localhost',
  $thrift_port                   = 6627,
  $thrift_threads                = 256,
  $thrift_max_buffer_size        = 6000000,
  $childopts                     = '-Xmx1024m',
  $task_timeout_secs             = 30,
  $supervisor_timeout_secs       = 60,
  $monitor_freq_secs             = 10,
  $cleanup_inbox_freq_secs       = 600,
  $inbox_jar_expiration_secs     = 3600,
  $task_launch_secs              = 120,
  $reassign                      = true,
  $file_copy_expiration_secs     = 600,
  $topology_validator            = 'backtype.storm.nimbus.DefaultTopologyValidator',
  $credential_renewers_freq_secs = 600,
  $retry_times                   = 5,
  $retry_interval_millis         = 2000,
  $retry_intervalceiling_millis  = 60000,
  $jvm                           = [
    '-Dlog4j.configuration=file:/etc/storm/storm.log.properties',
    '-Dlogfile.name=nimbus.log'],
  $config_file                   = $storm::config_file
) inherits storm {

  concat::fragment { 'nimbus':
    ensure  => present,
    target  => $config_file,
    content => template("${module_name}/storm_nimbus.erb"),
    order   => 2,
  }

  # Install nimbus /etc/default

  storm::service { 'nimbus':
    manage_service => $manage_service,
    config_file    => $config_file,
    force_provider => $force_provider,
    enable         => $enable,
    ensure_service => $ensure_service,
    jvm_memory     => $mem,
    opts           => $jvm,
    require        => Class['storm::config']
  }
}
