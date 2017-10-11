class profiles::docker::server (
  $tcp_host_uri = 'tcp://localhost:2375',
) {

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

  file_line { 'configure storage_driver':
    path   => '/etc/sysconfig/docker-storage-setup',
    line   => 'STORAGE_DRIVER=overlay2',
    match  => '^STORAGE_DRIVER',
    notify => Service['docker-storage-setup','docker'],
  }

  file_line { 'configure docker options':
    path   => '/etc/sysconfig/docker',
    line   => "OPTIONS='-H ${tcp_host_uri} -H unix:///var/run/docker.sock --selinux-enabled --log-driver=journald --signature-verification=false'",
    match  => '^OPTIONS',
    notify => Service['docker-storage-setup','docker'],
  }

  # set tcp_host_uri globally ...

  file { '/etc/profile.d/docker.sh':
    ensure  => file,
    content => "export DOCKER_HOST=${tcp_host_uri}",
  }
}
