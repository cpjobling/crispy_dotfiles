class drush-vagrant::user {

  group { 'puppet': ensure => present, }

  user {$username:
    ensure => present,
    groups => 'sudo',
    home   => "/home/${username}",
    shell  => '/bin/bash',
  }

  # Various dotfiles
  File { ensure => present,
         owner  => "${username}",
         group  => "${username}",
  }
  file { "/home/${username}":
           ensure => directory,
           before => [ File['.profile'], File['.bashrc'], File['.bash_aliases'], File['.vimrc'], File["/home/${username}/.ssh"] ];
         "/home/${username}/.ssh":
           ensure => directory,
           before => File['.ssh/authorized_keys'];
         ".profile":
           source => ["/vagrant/.config/files/.profile",
                      "puppet:///modules/drush-vagrant/profile.example"],
           path   => "/home/${username}/.profile";
         ".bashrc":
           source => ["/vagrant/.config/files/.bashrc",
                      "puppet:///modules/drush-vagrant/bashrc.example"],
           path   => "/home/${username}/.bashrc";
         ".bash_aliases":
           source => ["/vagrant/.config/files/.bash_aliases",
                      "puppet:///modules/drush-vagrant/bash_aliases.example"],
           path   => "/home/${username}/.bash_aliases";
         ".vimrc":
           source => ["/vagrant/.config/files/.vimrc",
                      "puppet:///modules/drush-vagrant/vimrc.example"],
           path   => "/home/${username}/.vimrc";
         ".ssh/authorized_keys":
           source => "/vagrant/.config/files/authorized_keys",
           path   => "/home/${username}/.ssh/authorized_keys";
  }

  #git username & email
  include git

  Exec { user        => $username,
         group       => $username,
         environment => "HOME=/home/${username}",
         path        => '/usr/bin',
         require     => Class['git'],
  }
  if $git_name {
    exec {"git config --global user.name '${git_name}'":}
  }
  if $git_email {
    exec {"git config --global user.email ${git_email}":}
  }

}
