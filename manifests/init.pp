# Class: storm
#
# This module install Storm binary package (does not manage repositories yet)
#
#
# Sample Usage:
#
#  class {'storm': }
#
class storm(
  $java_library_path                           = ['/usr/local/lib', '/opt/local/lib', '/usr/lib'],
  $local_dir                                   = '/usr/lib/storm/storm-local',
  $user                                        = 'root',
  $group                                       = 'root',
  $home                                        = '/usr/lib/storm',
  $version                                     = '1.0.2',
  $lib                                         = '/usr/lib/storm/lib',
  # JAR path will be "$lib/$jar_prefix-$version.jar"
  $jar_prefix                                  = 'storm',
  $conf                                        = '/etc/storm',
  $classpath                                   = ['$STORM_LIB/*.jar', '$STORM_JAR', '$STORM_CONF'],
  $options                                     = [''],
  $cluster_mode                                = 'distributed',
  $local_mode_zmq                              = false,
  $zookeeper_servers                           = ['localhost'],
  $zookeeper_port                              = 2181,
  $zookeeper_root                              = '/storm',
  $zookeeper_session_timeout                   = 20000,
  $zookeeper_retry_times                       = 5,
  $zookeeper_retry_interval                    = 1000,
  $transactional_zookeeper_root                = '/stormtransactional',
  $transactional_zookeeper_servers             = 'null',
  $transactional_zookeeper_port                = 2181,
  $config_file                                 = '/etc/storm/storm.yaml',
  $dev_zookeeper_path                          = '/tmp/dev-storm-zookeeper',
    #_ WORKERS _#
  $worker_childopts                            = '-Xmx768m',
  $worker_heartbeat_frequency_secs             = 1,
  $task_heartbeat_frequency_secs               = 3,
  $task_refresh_poll_secs                      = 10,

  #_ NETTY _#
  $netty_server_worker_threads                 = 1,
  $netty_client_worker_threads                 = 1,
  $netty_buffer_size                           = 5242880, #5MB buffer
  $netty_max_retries                           = 300,
  $netty_max_wait_ms                           = 1000,
  $netty_min_wait_ms                           = 100,
  $netty_transfer_batch_size                   = 262144,
  $netty_socket_backlog                        = 500,
  $netty_authentication                        = false,
  $group_mapping_service_cache_duration_secs   = 120,
  #_ 0MQ _#
  $zmq_threads                                 = 1,
  $zmq_linger_millis                           = 5000,

  #_ TOPOLOGY _#
  $topology_kryo_register                      = [''],
  $topology_debug                              = false,
  $topology_optimize                           = true,
  $topology_workers                            = 1,
  $topology_ackers                             = 1,
  $topology_message_timeout_secs               = 30,
  $topology_skip_missing_kryo_registrations    = false,
  $topology_max_task_parallelism               = 'null',
  $topology_max_spout_pending                  = 'null',
  $topology_state_synchronization_timeout_secs = 60,
  $topology_stats_sample_rate                  = '0.05',
  $topology_fall_back_on_java_serialization    = true,
  $topology_worker_childopts                   = 'null',
  $topology_sleep_spout_wait_strategy_time_ms  = 1,
  $packages                                    = ['storm'],
  $packages_ensure                             = 'present',
) {

  validate_array($java_library_path)
  validate_array($classpath)
  validate_array($options)
  validate_array($zookeeper_servers)
  validate_array($topology_kryo_register)

  class {'storm::install':
    user     => $user,
    group    => $group,
    ensure   => $packages_ensure,
    packages => $packages,
  }

  class {'storm::config':
    java_library_path => $java_library_path,
    user              => $user,
    home              => $home,
    version           => $version,
    lib               => $lib,
    jar_prefix        => $jar_prefix,
    conf              => $conf,
    classpath         => $classpath,
    options           => $options,
    require           => Class['storm::install']
  }

  concat { $config_file:
    owner   => $user,
    group   => $group,
    mode    => '0644',
    require => Class['storm::install'],
  }

  concat::fragment { 'core':
    ensure  => present,
    target  => $config_file,
    content => template("${module_name}/storm_core.erb"),
    order   => 1,
  }

}
