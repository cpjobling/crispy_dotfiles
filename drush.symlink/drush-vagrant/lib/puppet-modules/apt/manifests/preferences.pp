define apt::preferences (
  $ensure = 'present',
  $source = '',
  $content = undef )
{

  if $source == '' and $content == undef {
    fail("One of \$source or \$content must be specified for apt::preferences ${name}")
  }
  if $source != '' and $content != undef {
    fail("Only one of \$source or \$content must specified for apt::preferences ${name}")
  }

  file { "/etc/apt/preferences.d/${name}":
    ensure => $ensure,
    owner => root, group => 0, mode => 0644,
    notify => Exec['update_apt'];
  }

  if $source {
    File["/etc/apt/preferences.d/${name}"] {
      source => $source,
    }
  }
  else {
    File["/etc/apt/preferences.d/${name}"] {
      content => $content,
    }
  }
}
