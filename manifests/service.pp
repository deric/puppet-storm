# Define: storm::service
#
# This module manages storm serviceation
#
# Parameters: None
#
# Actions: None
#
# Requires: storm::install
#
# Sample Usage: storm::service { 'nimbus':
#                 start      => 'yes',
#                 jvm_memory => '1024m',
#                 opts       => ['-Dlog4j.configuration=file:/etc/storm/storm.log.properties', '-Dlogfile.name=nimbus.log']
#               }
#
define storm::service( $start = 'no', $enable = false, $jvm_memory = '768m', $opts = []) {

  file { "/etc/default/storm-${name}":
    require => Package['storm'],
    content => template('storm/default-service.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }
  
  if $start == 'yes' {
    service { "storm-${name}":
      ensure    => "running",
      hasstatus => true,
      enable    => $enable,
      subscribe => [File["/etc/storm/storm.yaml"], File["/etc/default/storm"], File["/etc/default/storm-${name}"]],
    }
  }


}
