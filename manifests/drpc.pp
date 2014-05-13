# Class: storm::drpc
#
# This module manages storm drpcation
#
# Parameters: None
#
# Actions: None
#
# Requires: storm:install
#
# Sample Usage: include storm::drpc
#
class storm::drpc {
  require storm::install
  include storm::config
  include storm::params

  # Variables
  $storm_drpc = $::storm::storm_drpc
  $storm_drpc_jvm_memory = $::storm::storm_drpc_jvm_memory

  # Ordering
  Class['storm::install'] ->
  Class['storm::config'] ->
  Class['storm::drpc'] ~>
  Class['storm::service::drpc']

  Class['storm::config'] ~>
  Class['storm::service::drpc']

  # Install drpc /etc/default
  storm::service { 'drpc':
    start      => 'yes',
    enable     => true,
    jvm_memory => $storm::params::drpc_mem,
    opts       => $storm::params::drpc_jvm,
  }

}
