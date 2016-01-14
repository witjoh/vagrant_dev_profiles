# module taht gathers most stuff needed to
# perform proper puppet testing
# This shoudl be installed on all slaves
# where puppetmodules will be tested
# Geared towards rake based testing
#
class profiles::jenkins::testtools {

  include ::profiles::packages
  
  package { ['rubygem-bundler', 'ruby-devel', 'rubygem-rake']:
    ensure => present,
  }
}
