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
) {

  class {'storm::install':

  }

  class {'storm::config':
    java_library_path => $java_library_path,
    user              => $user,
    home              => $home,
    user              => $user,
    version           => $version,
    lib               => $lib,
    jar               => $jar,
    conf              => $conf,
    classpath         => $classpath,
    options           => $options,
    require           => Class['storm::install']
  }

}
