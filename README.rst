This module is created to manage autofs mountpoints.

A new type is created, automount, that manages /etc/auto.master.

automount{'/mnt/a_mount_point':  
	ensure => absent,  
	map => "/etc/map.auto",  
	options => "--timeout=60"
}

