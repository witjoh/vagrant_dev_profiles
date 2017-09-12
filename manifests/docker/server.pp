class profiles::docker::server {

  class { '::docker':
    docker_users => [ 'vagrant' ],
  }
}
