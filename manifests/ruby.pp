# handles the isntallation of rvm and pupept supported ruby versions
#
# Ruby version  Puppet 3.x                Puppet 4.x
# 2.2.x         No                        Lightly Tested
# 2.1.x         Tested (3.5 and higher)   Tested
# 2.0.x         Tested (3.2 and higher)   Lightly Tested
# 1.9.3*        Tested                    Lightly Tested
# 1.8.7         Tested                    No
#
# Te default : 2.1.x
#
# tweaking with the native puppet ruby version is bad idea
# We broke puppet trying this.
#
# We choose for rvm, since it is also supported by jenkins
#
class profiles::ruby (
  Array[String] $supported_ruby_versions = [ 'ruby-1.9.3-p551','ruby-2.0.0-p648','ruby-2.1.9','ruby-2.2.5','ruby-2.3.1' ],
  String         $default_ruby_version    = 'ruby-2.2.5',
)  {

  ### we really have dependencies troublesto make the key accepted ...

  stage { 'rvm_prep' :
    before => Stage['main'],
  }

  class { 'profiles::rvm_key':
    stage => 'rvm_prep',
  }

  class { 'rvm':
    gnupg_key_id => false,
  }

  rvm::system_user { vagrant: }

  $supported_ruby_versions.each | String $version| {
    if $version == $default_ruby_version {
      $default_version = true
    }  else {
      $default_version = false
    }

    rvm_system_ruby { $version:
      ensure      => 'present',
      default_use => $default_version,
    }

    rvm_gem { "${version}/bundler":
      ensure  => present,
      require => Rvm_system_ruby[$version],
    }
    rvm_gem { "${version}/puppet-retrospec":
      ensure  => present,
      require => Rvm_system_ruby[$version],
    }

    rvm_gem { "${version}/nokogiri":
      ensure   => present,
      withopts => "-- --use-system-libraries -v='1.6.6.4'",
      require  => Rvm_system_ruby[$version],
    }
  }
}
