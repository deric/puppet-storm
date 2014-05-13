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
class storm::nimbus {
  require storm::install
  include storm::config
  include storm::params

  Class['storm::config'] ~>
  Class['storm::service::nimbus']

  # Install nimbus /etc/default
  storm::service { 'nimbus':
    start      => 'yes',
    enable     => true,
    jvm_memory => $storm::params::nimbus_mem,
    opts       => $storm::params::nimbus_jvm,
  }

}
