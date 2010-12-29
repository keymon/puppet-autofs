#
# autofs module
#
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

# modules_dir { "autofs": }

class autofs {
    include autofs::base
}

class autofs::base {
    # autofs needs nfs
    include nfs

    package { autofs:
        ensure => installed,
    }

    file { "/etc/auto.master":
        source => [ "puppet://$server/files/autofs/etc/${fqdn}/auto.master",
                    "puppet://$server/files/autofs/etc/${domain}/auto.master",
                    "puppet://$server/files/autofs/etc/auto.master",
                    "puppet://$server/autofs/etc/auto.master.${operatingssystem}",
                    "puppet://$server/autofs/etc/auto.master" ],
        notify => Service[autofs],
        owner => root, group => 0, mode => 0644;
    }

    service { autofs:
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package[autofs],
    }
}
