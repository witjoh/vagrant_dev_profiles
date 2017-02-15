# Installs a standalone monolitic puppetdb to be used
# in a masterless setup
#
# Mainly to help testing exported resources without setting up
# a complete puppet master stack
#
class profiles::puppetdb::masterless::server {

  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }

  include ::puppetrepos

  class { '::apache':
    default_vhost => false,
  }
  include ::apache::mod::proxy
  include ::apache::mod::ssl

  apache::vhost { 'puppetdb_proxy':
    servername => $::fqdn,
    docroot    => '/var/www/html/puppetdb',
    ssl        => true,
    port       => 8081,
    proxy_pass => {
      path     => '/',
      url      => 'http://localhost:8080/',
    },
  }

  # we only listen to localhost:8080 and use aal terminating apache proxy
  # to redirect to the puppeetdb server

  class { '::puppetdb':
    disable_ssl     => true,
    manage_firewall => false,
  }

}

