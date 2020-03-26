# profiles::dev_env
#
# Profile to manage all stuff  we need to
# become a better TDD developer
#
class profiles::dev_env(
  String $git_name,
  String $git_email,
  String $git_user  = 'vagrant',
)  {

  # install vim syntax highlighting and inline code checkers
  #

  package { 'git':
    ensure => present,
  }

  file { "/home/${git_user}/.gitconfig": 
    ensure  => file,
    content => "[user]\n        name = ${git_name}\n        email = ${git_email}\n[color]\n        ui = true",
    owner   => $git_user,
    group   => $git_user,
    mode    => '0664',
  }

  class{ "vim":
      user_list => ['vagrant'],
      require   => Package['git'],
  }

  # Checkout the puppet3 adopted skeleton (used @ vdab)
  class{ "skeleton":
      user_list => ['vagrant'],
      branch    => 'puppet3',
      require   => Package['git'],
  }

  $profile_content = @(END)
  # Add /opt/puppetlabs/puppet/bin to the path for sh compatible users
  # Modified for Vagrant dev stations
  if ! echo $PATH | grep -q /opt/puppetlabs/puppet/bin ; then
    export PATH=$PATH:/opt/puppetlabs/puppet/bin
  fi
  | END

  file { '/etc/profile.d/puppet-agent.sh':
    ensure  => file,
    content => $profile_content,
  }
}
