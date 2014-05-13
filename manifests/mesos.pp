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
  $executor_uri         = undef,
  $framework_role       = '*',
  $framework_checkpoint = false,
  $enable               = false,
  $jvm                  = [],
) inherits storm {

  validate_array($jvm)

  concat::fragment { 'mesos':
    ensure   => present,
    target   => $config_file,
    content  => template("${module_name}/storm_mesos.erb"),
    order    => 6,
  }

  package { 'storm-mesos':
    ensure  => 'installed',
  }

  # Install ui /etc/default
  storm::service { 'mesos':
    start      => 'yes',
    enable     => $enable,
    jvm_memory => $mem,
    opts       => $jvm,
    require    => Package['storm-mesos'],
  }

}
