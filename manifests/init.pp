# == Class: portmap
#
# Installs and manages the port mapper daemon.
#
# === Parameters
#
# Document parameters here.
#
# [*package*]
#   Corresponds to the ensure parameter of the Package resource type.
#
# [*service*]
#   Corresponds to the ensure parameter of the Service resource type.
#
# [*enable*]
#   Corresponds to the enable parameter of the Service resource type.
#
# === Variables
#
# This module requires no variables.
#
# === Examples
#
#  class { 'portmap':
#    package => installed,
#    service => running,
#    enable  => true,
#  }
#
# === Authors
#
# Joseph Beard <joseph.beard@leadingedje.com>
#
# === Copyright
#
# Copyright 2014 Joseph Beard
#
class portmap (
    $package = installed,
    $service = running,
    $enable  = true,
) inherits portmap::params {

    anchor { 'portmap::begin': }

    case $::operatingsystem {
        centos, redhat : {
            class { 'portmap::rhel':
                package => $package,
                service => $service,
                enable  => $enable,
            }
        }
        debian : {
            class { 'portmap::debian':
                package => $package,
                service => $service,
                enable  => $enable,
            }
        }
        default : {
            fail("portmap is not currently supported on ${::operatingsystem}")
        }
    }

    anchod { 'portmap::end': }

}
