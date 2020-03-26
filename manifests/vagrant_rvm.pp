# Installs rvm for the user vagrant only

class profiles::vagrant_rvm {

  include profiles::rvm_key

  user { 'vagrant':
    ensure => present,
  }

  single_user_rvm::install { 'vagrant':
    require =>  Class['profiles::rvm_key'],
  }

  # puppet ruby versions : 6 2.5.7p206
  # puppet ruby versions : 5 2.4.9p362
  single_user_rvm::install_ruby { 'ruby-2.5.7': user => 'vagrant' }
  single_user_rvm::install_ruby { 'ruby-2.4.9': user => 'vagrant' }
}
