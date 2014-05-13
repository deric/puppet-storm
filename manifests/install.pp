# Class: storm::install
#
# This module manages storm installation
#
# Parameters: None
#
# Actions: None
#
# Requires:
#
# Sample Usage: include storm::install
#
class storm::install(
 $ensure = 'installed',
) {

  package { ['storm', 'libjzmq', 'libzmq0']:
    ensure => $ensure,
  }

}
