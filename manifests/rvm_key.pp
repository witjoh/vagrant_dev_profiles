class profiles::rvm_key {

  # dirty hack to get the gpg key in proper place before 
  # we isntall rvm
  # and the gpg_key => false attribute does not work

  # this key must be available and active before puppet run
  # mormal dependencies does not work
  # using stages ....

  exec { 'rvm_gpg_key':
    command    => '/usr/bin/gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3',
    unless => '/usr/bin/gpg2 --list-keys rvm',
  }

}
