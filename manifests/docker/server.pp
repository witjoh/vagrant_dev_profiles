class profiles::docker::server {

  #class { '::docker':
  #  docker_users                => [ 'vagrant' ],
  #  use_upstream_package_source => false,
  #  package_name                => 'docker',
  #  docker_group                => 'dockerroot',
  #}

  package { 'docker':
    ensure =>  present,
  }

  # bug in rpm .... 
  # /usr/bin/docker-current: Error response from daemon: shim error: docker-runc not installed on system.
  #

  file { '/usr/libexec/docker/docker-runc':
    ensure  => link,
    target  => '/usr/libexec/docker/docker-runc-current',
    require => Package['docker'],
  }

  group { 'dockerroot':
    members => ['vagrant'],
    require => Package['docker'],
  }
}
