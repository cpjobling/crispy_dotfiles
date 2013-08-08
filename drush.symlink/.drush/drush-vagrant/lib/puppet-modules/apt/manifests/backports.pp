class apt::backports {
  include apt
  if ( $lsbdistcodename == 'lenny' ) {
    # XXX temporary. this'll need to go when all servers are upgraded to squeeze
    apt::sources_list { "${lsbdistcodename}-backports":
      content => "deb http://archive.debian.org/backports.org ${lsbdistcodename}-backports main";
    }
  }
  else {
    apt::sources_list { "${lsbdistcodename}-backports":    content => "deb http://backports.debian.org/debian-backports ${lsbdistcodename}-backports main"; }
  }
}

