# Class: storm::nimbus
#
# This module manages storm nimbusation
#
# Parameters: None
#
# Actions: None
#
# Requires: storm::install
#
# Sample Usage: include storm::nimbus
#
class storm::nimbus(
  $mem                       = '1024m',
  $host                      = 'localhost',
  $thrift_port               = 6627,
  $childopts                 = '-Xmx1024m',
  $task_timeout_secs         = 30,
  $supervisor_timeout_secs   = 60,
  $monitor_freq_secs         = 10,
  $cleanup_inbox_freq_secs   = 600,
  $inbox_jar_expiration_secs = 3600,
  $task_launch_secs          = 120,
  $reassign                  = true,
  $file_copy_expiration_secs = 600,
  $jvm                       = [
    '-Dlog4j.configuration=file:/etc/storm/storm.log.properties',
    '-Dlogfile.name=nimbus.log'],
) inherits storm {
  #require storm::install

  concat::fragment { 'nimbus':
    ensure   => present,
    target   => $config_file,
    content  => template("${module_name}/storm_nimbus.erb"),
    order    => 2,
  }

  # Install nimbus /etc/default
  storm::service { 'nimbus':
    start      => 'yes',
    enable     => true,
    jvm_memory => $mem,
    opts       => $jvm,
    require    => Class['storm::config']
  }

}
