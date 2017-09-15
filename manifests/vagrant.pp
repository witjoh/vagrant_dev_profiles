# installs and configures vagrant from local repo.
# This repo is not managed by this profile
# Configures also the plugins for the vagrant user.
#
class profiles::vagrant {

  class { 'vagrant':
    provider => 'yum',
  }


}
