class profiles::retrospec (
  String $template_repo = 'git@git.vdab.be:op/puppet/misc/retrospec-templates.git',
  String $template_branch = 'vdab',
) {

  file { '/home/vagrant/.retrospec':
    ensure => directory,
    mode   => '0755',
    owner  => 'vagrant',
    group  => 'vagrant',
  }

  file { '/home/vagrant/.retrospec/config.yaml':
    ensure => file,
    mode   => '0644',
    owner  => 'vagrant',
    group  => 'vagrant',
  }

  yaml_settings { '/home/vagrant/.retrospec/config.yaml':
    values                              => {
      'plugins::puppet::templates::url' => $template_repo,
      'plugins::puppet::templates::ref' => $template_branch,
    }
  }
}
