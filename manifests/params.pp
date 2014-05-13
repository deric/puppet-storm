# Class: storm::params
#
# This module manages storm::params
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class storm::params {


  #_ SUPERVISOR _#
  $supervisor_mem                       = hiera('supervisor_mem', '1024m')
  $supervisor_start_port                = hiera('supervisor_slots_start_port', '6700')
  $supervisor_workers                   = hiera('supervisor_workers', '4')
  $supervisor_childopts                 = hiera('supervisor_childopts', '-Xmx1024m')
  $supervisor_worker_start_timeout_secs = hiera('supervisor_worker_start_timeout_secs', '120')
  $supervisor_worker_timeout_secs       = hiera('supervisor_worker_timeout_secs', '30')
  $supervisor_monitor_frequency_secs    = hiera('supervisor_monitor_frequency_secs', '3')
  $supervisor_heartbeat_frequency_secs  = hiera('supervisor_heartbeat_frequency_secs', '5')
  $supervisor_enable                    = hiera('supervisor_enable', 'true')
  $supervisor_jvm                       = hiera('supervisor_jvm', ['-Dlog4j.configuration=file:/etc/storm/storm.log.properties', '-Dlogfile.name=supervisor.log'])

  #_ WORKERS _#
  $worker_childopts                = hiera('worker_childopts', '-Xmx768m')
  $worker_heartbeat_frequency_secs = hiera('worker_heartbeat_frequency_secs', '1')
  $task_heartbeat_frequency_secs   = hiera('task_heartbeat_frequency_secs', '3')
  $task_refresh_poll_secs          = hiera('task_refresh_poll_secs', '10')

  #_ 0MQ _#
  $zmq_threads       = hiera('zmq_threads', '1')
  $zmq_linger_millis = hiera('zmq_linger_millis', '5000')

  #_ TOPOLOGY _#
  $topology_kryo_register                      = hiera_array('topology_kryo.register', [''])
  $topology_debug                              = hiera('topology_debug', 'false')
  $topology_optimize                           = hiera('topology_optimize', 'true')
  $topology_workers                            = hiera('topology_workers', '1')
  $topology_ackers                             = hiera('topology_tasks', '1')
  $topology_message_timeout_secs               = hiera('topology_message_timeout_secs', '30')
  $topology_skip_missing_kryo_registrations    = hiera('topology_skip_missing_kryo_registrations', 'false')
  $topology_max_task_parallelism               = hiera('topology_max_task_parallelism', 'null')
  $topology_max_spout_pending                  = hiera('topology_max_spout_pending', 'null')
  $topology_state_synchronization_timeout_secs = hiera('topology_state_synchronization_timeout_secs', '60')
  $topology_stats_sample_rate                  = hiera('topology_stats_sample_rate', '0.05')
  $topology_fall_back_on_java_serialization    = hiera('topology_fall_back_on_java_serialization', 'true')
  $topology_worker_childopts                   = hiera('topology_worker_childopts', 'null')

}
