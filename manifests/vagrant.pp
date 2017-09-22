# installs and configures vagrant from local repo.
# This repo is not managed by this profile
# Configures also the plugins for the vagrant user.
#
class profiles::vagrant {

  class { 'vagrant':
    provider => 'yum',
  }

  vagrant::plugin { 'vagrant-hostmanager_vagrant':
    plugin => 'vagrant-hostmanager',
    user   => 'vagrant'
  }

  # install dependencies to be able to install the vagrant-libvirt plugin

  $libvirt_dependencies = [ 'libvirt', 'libvirt-devel', 'ruby-devel', 'qemu-kvm' ]

  package { $libvirt_dependencies:
    ensure => present,
  }

  vagrant::plugin { 'vagrant-libvirt_vagrant':
    plugin  => 'vagrant-libvirt',
    user    => 'vagrant',
    require => Package[$libvirt_dependencies],
  }

  profiles::packer { 'vagrant': }

}
