# Installs rvm for the user vagrant only

class profiles::vagrant_rvm {

  include profiles::rvm_key

  user { 'vagrant':
    ensure => present,
  }

  single_user_rvm::install { 'vagrant':
    require =>  Class['profiles::rvm_key'],
  }

  [ 'ruby-2.5.7', 'ruby-2.4.9' ].each | String $version | {

    single_user_rvm::install_ruby { $version:
      user => 'vagrant',
    }

    single_user_rvm::gem { "${version}-bundler":
      ensure      => present,
      ruby_string => $version,
      user        => 'vagrant',
      gem         => 'bundler',
    }

    single_user_rvm::gem { "${version}-puppet-retrospec":
      ensure      => present,
      ruby_string => $version,
      user        => 'vagrant',
      gem         => 'puppet-retrospec',
    }

    single_user_rvm::gem { "${version}-nokogiri":
      ensure      => present,
      ruby_string => $version,
      user        => 'vagrant',
      gem         => 'nokogiri',
    }
    #withopts => "-- --use-system-libraries -v='1.6.6.4'",
  }
}
