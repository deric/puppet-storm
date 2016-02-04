# Class: storm::mesos
#
# By default service is disabled - service should provide framework
# which needs to run on one node, though executors we need on each node.
#
#
# Actions: None
#
# Requires: storm::install
#
# Sample Usage:
#
#  class {'storm::mesos':
#     master_url => 'zk://localhost:2181/mesos'
#  }
#
class storm::mesos(
  $master_url,
  $manage_service       = false,
  $enable               = true,
  $ensure_service       = 'running',
  $force_provider       = undef,
  $executor_uri         = undef,
  $framework_role       = '*',
  $framework_checkpoint = false,
  $jvm                  = [],
  $mem                  = '512m',
  $config_file          = $storm::config_file,
) inherits storm {

  validate_array($jvm)

  concat::fragment { 'mesos':
    ensure  => present,
    target  => $config_file,
    content => template("${module_name}/storm_mesos.erb"),
    order   => 6,
  }

  ensure_packages(['storm-mesos'])

  # Install ui /etc/default
  storm::service { 'mesos':
    manage_service => $manage_service,
    force_provider => $force_provider,
    enable         => $enable,
    ensure_service => $ensure_service,
    config_file    => $config_file,
    jvm_memory     => $mem,
    opts           => $jvm,
    require        => Package['storm-mesos'],
  }

}
