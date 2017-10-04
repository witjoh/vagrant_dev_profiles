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

  service {'docker':
    ensure  => running,
    enable  => true,
    require => Package['docker'],
  }


  service {'docker-storage-setup':
    ensure  => running,
    enable  => true,
    require => Package['docker'],
  }

  # bug in rpm .... 
  # /usr/bin/docker-current: Error response from daemon: shim error: docker-runc not installed on system.
  #

  file { '/usr/libexec/docker/docker-runc':
    ensure  => link,
    target  => '/usr/libexec/docker/docker-runc-current',
    require => Package['docker'],
  }

  file_line { 'configure storage_driver':
    path   => '/etc/sysconfig/docker-storage-setup',
    line   => 'STORAGE_DRIVER=overlay2',
    match  => '^STORAGE_DRIVER',
    notify => Service['docker-storage-setup','docker'],
  }
}
