class profiles::docker::registry {

  docker::run { 'registry':
    ensure           => absent,
    image            => 'registry:2',
    ports            => ['5000:5000'],
    volumes          => ['/vagrant/repos/docker-registry/data:/var/lib/registry'],
    extra_parameters => [ '--restart=always' ],
  }

  # only in RedHat based systems

  packer { 'docker-registry':
    ensure => latest,
  }
}
