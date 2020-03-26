class profiles::rvm_key {

  include gnupg

  gnupg_key { "rvm_mpapis}":
    ensure     => present,
    key_id     => 'D39DC0E3',
    user       => 'vagrant',
    key_server => 'hkp://pool.sks-keyservers.net',
    key_type   => public,
  }

  gnupg_key { "rvm_pkuczynski}":
    ensure     => present,
    key_id     => '39499BDB',
    user       => 'vagrant',
    key_server => 'hkp://pool.sks-keyservers.net',
    key_type   => public,
  }
}
