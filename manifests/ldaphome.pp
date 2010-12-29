# manifests/ldaphome.pp

class autofs::ldaphome inherits autofs {
    file{"/etc/auto.ldaphome":
        source => [ "puppet://$server/files/autofs/etc/${fqdn}/auto.ldaphome",
                    "puppet://$server/files/autofs/etc/${domain}/auto.ldaphome",
                    "puppet://$server/files/autofs/etc/auto.ldaphome",
                    "puppet://$server/autofs/etc/auto.ldaphome" ],
        require => File["/etc/auto.master"],
        notify => Service[autofs],
        owner => root, group => 0, mode => 0644;
    }
}
