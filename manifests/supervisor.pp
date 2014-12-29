# Class: storm::supervisor
#
# This module manages storm supervisoration
#
# Parameters: None
#
# Actions: None
##
# Sample Usage:
#
# class{'storm::supervisor': }
#
class storm::supervisor(
  $enable                    = true,
  $mem                       = '1024m',
  $start_port                = 6700,
  $workers                   = 4,
  $childopts                 = '-Xmx1024m',
  $worker_start_timeout_secs = 120,
  $worker_timeout_secs       = 30,
  $monitor_frequency_secs    = 3,
  $heartbeat_frequency_secs  = 5,
  $enable                    = true,
  $jvm                       = [
    '-Dlog4j.configuration=file:/etc/storm/storm.log.properties',
    '-Dlogfile.name=supervisor.log'
  ]
) inherits storm {

  validate_bool($enable)
  validate_array($jvm)

  concat::fragment { 'supervisor':
    ensure   => present,
    target   => $config_file,
    content  => template("${module_name}/storm_supervisor.erb"),
    order    => 5,
  }

  # Install supervisor /etc/default
  storm::service { 'supervisor':
    start       => 'yes',
    config_file => $config_file,
    enable      => $enable,
    jvm_memory  => $mem,
    opts        => $jvm,
  }

}
