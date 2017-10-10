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

  yaml_settings { '/etc/docker-distribution/registry/config.yml':
    values => {
      'storage/filesystem' => { 'rootdirectory' => '/vagrant/repos/docker-registry', },
      'storage.delete'     => { 'enabled'       => 'true', },
    },
    notify                 => Service['docker-distribution'],
    require                => Package['docker-distribution'],
  }

  service { 'docker-distribution':
    ensure  => running,
    enable  => true,
    require => Package['docker-distribution'],
  }

}
