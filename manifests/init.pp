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
class storm {
  include storm::install
  include storm::config

}
