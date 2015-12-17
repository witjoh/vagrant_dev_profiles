# class packages
#
#  Ungrouped, but supported packages needed to do 
# or to configure the testing setup
#
# Could be moved to proper module in time 
#
class profiles::packages {

  package { ['gcc', 'gcc-c++', 'zlib-devel', 'libxml2-devel', 'libxslt-devel']:
    ensure => present,
  }

}

