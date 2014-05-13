# Class: storm::mesos
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
#  class {'storm::mesos': }
#
class storm::mesos(
  $master_url,
  $executor_uri         = undef,
  $framework_role       = '*',
  $framework_checkpoint = false,
  $enable               = true,
  $jvm                  = [],
) inherits storm {

  validate_array($jvm)

  concat::fragment { 'mesos':
    ensure   => present,
    target   => $config_file,
    content  => template("${module_name}/storm_mesos.erb"),
    order    => 6,
  }

  # Install ui /etc/default
  storm::service { 'mesos':
    start      => 'yes',
    enable     => $enable,
    jvm_memory => $mem,
    opts       => $jvm,
  }

}
