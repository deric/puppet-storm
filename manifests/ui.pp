# Class: storm::ui
#
# This module manages storm uiation
#
# Parameters: None
#
# Actions: None
#
# Requires: storm::install
#
# Sample Usage: include storm::ui
#
class storm::ui {
  require storm::install
  include storm::config
  include storm::params

  Class['storm::config'] ~>
  Class['storm::service::nimbus']

  # Install ui /etc/default
  storm::service { 'ui':
    start      => 'yes',
    enable     => true,
    jvm_memory => $storm::params::ui_mem,
    opts       => $storm::params::ui_jvm,
  }

}
