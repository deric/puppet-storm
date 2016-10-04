# Class: storm::install
#
# This module manages storm installation
#
# Parameters: None
#
# Actions: None
#
#
# Normally we need just 'storm' package, however you might want to pass
# other dependencies, like 'libjzmq' etc.
#
#
class storm::install(
  $packages = ['storm'],
  $ensure   = 'latest',
  $conf     = '/etc/storm',
) {

  ensure_resource('package', $packages, {'ensure' => $ensure })

  file { $conf:
    ensure => 'directory',
    mode   => '0750',
  }
}
