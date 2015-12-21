class profiles::gitserver {

  class { 'gitlab':
    external_url => 'http://gitlab.koewacht.net',
    edition      => 'ce',
  }

}
