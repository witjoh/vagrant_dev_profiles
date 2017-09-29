class profiles::docker::server {

  class { '::docker':
    docker_users                => [ 'vagrant' ],
    use_upstream_package_source => false,
    package_name                => 'docker',
  }
}
