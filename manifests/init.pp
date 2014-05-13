# Class: storm
#
# This module manages storm
#
# Parameters: None
#
# Actions: None
#
# Requires: None
#
# Sample Usage:
#
#  class {'storm': }
#
class storm(
  $java_library_path = ['/usr/local/lib', '/opt/local/lib', '/usr/lib'],
  $local_dir         = '/usr/lib/storm/storm-local',
  $user              = 'root',
  $home              = '/usr/lib/storm',
  $version           = '0.9.1',
  $lib               = '/usr/lib/storm/lib',
  $jar               = '/usr/lib/storm/storm-${STORM_VERSION}.jar',
  $conf              = '/etc/storm',
  $classpath         = ['$STORM_LIB/*.jar', '$STORM_JAR', '$STORM_CONF'],
  $options           = [''],
  $cluster_mode      = 'distributed',
  $local_mode_zmq    = 'false',
  $zookeeper_servers            = ['localhost'],
  $zookeeper_port               = '2181',
  $zookeeper_root               = '/storm',
  $zookeeper_session_timeout    = '20000',
  $zookeeper_retry_times        = '5',
  $zookeeper_retry_interval     = '1000',
  $config_file                  = '/etc/storm/storm.yaml',
  $dev_zookeeper_path           = '/tmp/dev-storm-zookeeper',
) {

  validate_array($java_library_path)
  validate_array($classpath)
  validate_array($options)
  validate_array($zookeeper_servers)

  class {'storm::install': }

  class {'storm::config':
    java_library_path => $java_library_path,
    user              => $user,
    home              => $home,
    version           => $version,
    lib               => $lib,
    jar               => $jar,
    conf              => $conf,
    classpath         => $classpath,
    options           => $options,
    require           => Class['storm::install']
  }

  concat { $config_file:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment { 'core':
    ensure   => present,
    target   => $config_file,
    content  => template("${module_name}/storm_core.erb"),
    order    => 1,
  }

}
