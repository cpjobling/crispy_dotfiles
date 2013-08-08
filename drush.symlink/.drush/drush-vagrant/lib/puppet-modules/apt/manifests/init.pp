# apt.pp - common components and defaults for handling apt
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.
#
# With hints from
#  Micah Anderson <micah@riseup.net>
#  * backports key

class apt {

	# See README
	$real_apt_clean = $apt_clean ? {
		'' => 'auto',
		default => $apt_clean,
	}

	package { [ 'lsb-release', 'apt' ]: ensure => installed }

	case $custom_sources_list {
		'': {
			include default_sources_list
		}
		default: {
			config_file { "/etc/apt/sources.list":
				content => $custom_sources_list,
			}
		}
	}

	config_file {
		# this just pins unstable and testing to very low values
		"/etc/apt/preferences":
			source => "puppet://$servername/apt/preferences",
			# use File[apt_config] to reference a completed configuration
			# See "The Puppet Semaphor" 2007-06-25 on the puppet-users ML
			alias => 'apt_config',
			# only update together
			require => File["/etc/apt/sources.list"];
	}
	case $lsbdistcodename {
		"sid": {
			Config_file["/etc/apt/preferences"] { ensure => "absent" }
		}
	}
	config_file {
		# little default settings which keep the system sane
		"/etc/apt/apt.conf.d/from_puppet":
			content => "APT::Get::Show-Upgraded true;\nDSelect::Clean $real_apt_clean;\nAPT::Cache-Limit 142582912;\nAPT::Get::force-yes true;\nAcquire::PDiffs false;\n",
			before => Config_file[apt_config];
	}

	$apt_base_dir = "/var/lib/puppet/modules/apt"
	modules_dir { apt: }
	# watch apt.conf.d
	file { "/etc/apt/apt.conf.d": ensure => directory, checksum => mtime; }

	exec {
		# "&& sleep 1" is workaround for older(?) clients
		"/usr/bin/apt-get update":
			refreshonly => true,
                        alias => update_apt,
			subscribe => [ File["/etc/apt/sources.list"],
				File["/etc/apt/preferences"], File["/etc/apt/apt.conf.d"],
				Config_file[apt_config] ];
		"/usr/bin/apt-get update && /usr/bin/apt-get autoclean":
			require => [ File["/etc/apt/sources.list"],
				File["/etc/apt/preferences"], Config_file[apt_config] ],
			# Another Semaphor for all packages to reference
			schedule => daily,
			alias => apt_update;
	}

	case $lsbdistcodename {
		etch: {
			## This package should really always be current
			package { "debian-archive-keyring": ensure => latest, }
		}
	}
}

