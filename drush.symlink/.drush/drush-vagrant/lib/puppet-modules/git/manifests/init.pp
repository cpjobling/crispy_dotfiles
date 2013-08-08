# git/manifests/init.pp - install git
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

class git
{
	package {
		# primary git packages
		"git-core": ensure => installed, alias => "git";
                "git-svn": ensure => installed;
		# this is needed to clone http:// repos
		curl: ensure => installed;
	}
}

define git::clone ($source) {

	include git

	exec { "/usr/bin/git clone ${source} ${name}":
		creates => $name,
		require => Package["git-core"],
		before => File[$name],
	}

	file { $name: checksum => mtime }

}

class git::daemon
{
	include git

	file { "/srv/git":
		ensure => directory,
		mode => 2775, owner => root, group => coder,
	}


	file { "/etc/init.d/git-daemon":
		source => "puppet://$servername/git/init.d.git",
		mode => 0755, owner => root, group => root,
		notify => Service[git-daemon],
	}

	user { 
		git:
			provider => useradd,
			uid => 207,
			gid => nogroup,
			comment => "Git Daemon User",
			shell => "/bin/false",
			home => "/srv/git",
			before => Service[git-daemon],
	}

	service {
		git-daemon:
			ensure => running,
			enable => true,
			hasstatus => true,
			hasrestart => true,
			pattern => "git-daemon",
	}

}

class git::web
{
	include git
	include apache2

	package { gitweb: ensure => installed, require => Package[apache2] }

	apache2::site {
		gitweb:
			ensure => present,
			content => template("git/gitweb-site"),
			require_package => gitweb
	}

	case $projectroot {
		'': {
		$real_projectroot = "/var/cache/git/"
	}
	default: {
		$real_projectroot =  $projectroot
	}
	}

	file { "/etc/gitweb.conf":
		ensure => present,
		mode => 0644, owner => root, group => root,
		content => template("git/gitweb.conf")
	}

	file { "/etc/default/git-daemon":
		ensure => present,
		mode => 0644, owner => root, group => root,
		content => template("git/default"),
		before => Service[git-daemon]
	}


	# creates an appropriate symlink to export the repo via gitweb
	define export($bare = false, $description = "undescribed") {
		$repopath = $bare ? {
			true => "/srv/git/${name}",
			false => "/srv/git/${name}/.git"
		}
		file {
			"/var/cache/git/${name}": ensure => $repopath;
			"${repopath}/git-daemon-export-ok": ensure => present;
			"${repopath}/description": ensure => present, content => "${description}\n";
		}
	}
}

