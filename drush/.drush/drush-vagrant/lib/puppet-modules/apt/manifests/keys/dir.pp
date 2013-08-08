class apt::keys::dir {
  include apt::keys
  if $custom_key_dir {
    File["${apt::keys::base_dir}/keys.d"] {
      source => "$custom_key_dir",
      recurse => true,
    }
    exec { "custom_keys":
      command => "find ${apt::keys::base_dir}/keys.d -type f -exec apt-key add '{}' \\; && /usr/bin/apt-get update",
      subscribe => File["${apt::keys::base_dir}/keys.d"],
      refreshonly => true,
    }
    if $custom_preferences != false {
      Exec["custom_keys"] {
        before => Concatenated_file[apt_config],
      }
    }
  }

}
