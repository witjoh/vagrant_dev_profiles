# Installs a standalone monolitic puppetdb to be used
# in a masterless setup
#
# Mainly to help testing exported resources without setting up
# a complete puppet master stack
#
class profiles::puppetdb::masterless::client {

  include ::puppetrepos

  package { 'puppetdb-termini':
    ensure => installed,
  }

  file { "${settings::confdir}/puppet.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "[main]\n   storeconfigs = true\n   storeconfigs_backend = puppetdb\n   report = true\n   reports = puppetdb",
  }

  file { "${settings::confdir}/routes.yaml":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "---\napply:\n  catalog:\n    terminus: compiler\n    cache: puppetdb\n  resource:\n    terminus: ral\n    cache: puppetdb\n  facts:\n    terminus: facter\n    cache: puppetdb_apply",
  }

  file { "${settings::confdir}/puppetdb.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "[main]\n  server = puppetdb.${domain}\n  port = 8081\n  soft_write_failure = true",
  }
}
