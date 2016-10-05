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
  $user     = 'root',
  $group    = 'root',
  $packages = ['storm'],
  $ensure   = 'latest',
  $conf     = '/etc/storm',
) {

  ensure_resource('package', $packages, {'ensure' => $ensure })

  file { $conf:
    ensure => 'directory',
    owner  => $user,
    group  => $group,
    mode   => '0750',
  }
}
