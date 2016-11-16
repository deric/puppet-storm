# Class: storm::drpc
#
# This module manages storm drpc
#
# Requires: storm:install
#
# Sample Usage:
#
#  class{'storm::drpc': }
#
class storm::drpc(
  $authorizer_acl_filename         = 'drpc-auth-acl.yaml',
  $authorizer_acl_strict           = false,
  $childopts                       = '-Xmx768m',
  $manage_service                  = false,
  $enable                          = true,
  $ensure_service                  = 'running',
  $force_provider                  = undef,
  $max_buffer_size                 = 1048576,
  $mem                             = '1024m',
  $jvm                             = [
    '-Dlog4j.configuration=file:/etc/storm/storm.log.properties',
    '-Dlogfile.name=drpc.log'],
  $port                            = 3772,
  $queue_size                      = 128,
  $servers                         = [''],
  $http_port                       = 3774,
  $https_port                      = '-1',
  $invocations_threads             = 64,
  $invocations_port                = 3773,
  $https_keystore_password         = '',
  $https_keystore_type             = 'JKS',
  $http_creds_plugin               = 'backtype.storm.security.auth.DefaultHttpCredentialsPlugin',
  $request_timeout_secs            = 600,
  $transactional_zookeeper_root    = '/transactional',
  $transactional_zookeeper_servers = 'null',
  $transactional_zookeeper_port    = 'null',
  $worker_threads                  = 64,
  $config_file                     = $storm::config_file
) inherits storm {

  validate_array($jvm)
  validate_array($servers)

  concat::fragment { 'drpc':
    ensure  => present,
    target  => $config_file,
    content => template("${module_name}/storm_drpc.erb"),
    order   => 4,
  }

  # Install drpc /etc/default
  storm::service { 'drpc':
    ensure_service => $ensure_service,
    manage_service => $manage_service,
    force_provider => $force_provider,
    enable         => $enable,
    config_file    => $config_file,
    jvm_memory     => $mem,
    opts           => $jvm,
  }

}
