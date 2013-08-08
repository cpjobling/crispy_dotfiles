class apt::default_sources_list {
  if $lsbdistcodename == 'lenny' {
    # XXX temporary until we upgrade everything to squeeze. lenny
    # is now in archives.debian.org instead of normal mirrors and
    # is no longer on security.debian.org
    config_file {
      "/etc/apt/sources.list":
        content => template("apt/sources.list.lenny.erb");
    }
  }
  else {
    config_file {
      # include main and security
      # additional sources could be included via an array
      "/etc/apt/sources.list":
       content => template("apt/sources.list.erb");
    }
  }
}

