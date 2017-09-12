class profiles::docker::registry {

  docker::run { 'registry':
    image            => 'registry:2',
    ports            => ['5000'],
    expose           => ['5000'],
    extra_parameters => [ '--restart=always' ],
  }

  docker::registry { 'localhost:5000':
    require => Docker::Run['registry'],
  }
}
