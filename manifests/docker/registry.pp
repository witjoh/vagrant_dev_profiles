class profiles::docker::registry {

  #  docker::run { 'registry':
  #  ensure           => absent,
  #  image            => 'registry:2',
  #  ports            => ['5000:5000'],
  #  volumes          => ['/vagrant/repos/docker-registry/data:/var/lib/registry'],
  #  extra_parameters => [ '--restart=always' ],
  #}

  # only in RedHat based systems

  package { 'docker-distribution':
    ensure => present,
  }

  file_line { 'adjust registry data path':
    ensure  => present,
    path    => '/etc/docker-distribution/registry/config.yml',
    line    => '        rootdirectory: /vagrant/repos/docker-registry',
    match   => 'rootdirectory:',
    require => Package['docker-distribution'],
  }

  service { 'docker-distribution':
    ensure    => running,
    enable    => true,
    subscribe => File_line['adjust registry data path'],
  }


}
