# Define: storm::service
#
# This module manages storm serviceation
#
# Parameters:
#  [*manage_service*] - whether service should be manged by system default
#                       init system
#  [*enable*]         - automatic sevice start (`manage_service` must be `true`)
#  [*jvm_memory*]     - maximum memory for JVM
#  [*opts*]           - Java options which will be passed to service
#
#
# Requires: storm::install
#
# Sample Usage: storm::service { 'nimbus':
#                 manage_service => true,
#                 jvm_memory     => '1024m',
#                 opts           => ['-Dlog4j.configuration=file:/etc/storm/storm.log.properties', '-Dlogfile.name=nimbus.log']
#               }
#
define storm::service(
  $ensure_service = 'running',
  $manage_service = false,
  $force_provider = undef,
  $config_file    = '/etc/storm/storm.yaml',
  $enable         = true,
  $jvm_memory     = '768m',
  $opts           = [],
  $user           = 'root',
  $owner          = 'root',
  ) {

  file { "/etc/default/storm-${name}":
    content => template('storm/default-service.erb'),
    owner   => $owner,
    group   => $user,
    mode    => '0644',
    require => Class['storm::install'],
  }

  notify { "storm-${name}":
    message  =>   "service ${name} enable ${enable} manage ${manage_service}",
    withpath => true,
  }

  if $manage_service {
    service { "storm-${name}":
      ensure     => $ensure_service,
      hasstatus  => true,
      hasrestart => true,
      enable     => $enable,
      provider   => $force_provider,
      require    => Concat::Fragment[$name],
      subscribe  => [ Concat[$config_file],
        File['/etc/default/storm'],
        Concat::Fragment[$name]
      ],
    }
  }
}
