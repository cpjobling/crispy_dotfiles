define apt::keys::key (
  $ensure = 'present',
  $source = '',
  $content = undef )
{
  include apt::keys 

  file { "${apt::keys::base_dir}/keys.d/$name":
    ensure => $ensure,
    owner => root, group => 0, mode => 0644;
  }

  if $source {
    File["${apt::keys::base_dir}/keys.d/${name}"] {
      source => $source,
    }
  }
  else {
    File["${apt::keys::base_dir}/keys.d/${name}"] {
      content => $content,
    }
  }

  exec { "apt_key_add_${name}":
    command => "apt-key add ${apt::keys::base_dir}/keys.d/${name}",
    path => "/bin:/usr/bin:/sbin:/usr/sbin",
    refreshonly => true,
    subscribe => File["${apt::keys::base_dir}/keys.d/${name}"],
    notify => Exec['update_apt'];
  }
}
