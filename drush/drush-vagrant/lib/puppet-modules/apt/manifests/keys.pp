class apt::keys {
  include apt

  include common::moduledir
  $base_dir = "${common::moduledir::module_dir_path}/apt"

  file { "${apt::keys::base_dir}/keys.d":
    ensure => "directory",
    mode => 0755, owner => root, group => root,
  }
}
