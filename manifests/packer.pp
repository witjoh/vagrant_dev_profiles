# installs the packer software in the users (title) home directory
# or /usr/local/bin if installed for root
# This will be moved to its own module in the future
#
# example:
#
# profiles::packer { 'vagrant': }
#
# Installs packer in the vagrant $HOME/bin directory
#
define profiles::packer (
  $user           = $title,
  $home_dir       = undef,
  $archive_uri    = 'file:///vagrant/repos/archives',
  $packer_archive = 'packer_1.1.0_linux_amd64.zip',
) {


  if $home_dir {
    $install_dir = "${home_dir}/bin"
  } else {
    if $user == 'root' {
      $install_dir = '/usr/local/bin'
    } else {
      $install_dir = "/home/${user}/bin"
    }
  }

  file { $install_dir:
    ensure => directory,
    owner  => $user,
  }

  # dependencie for the archive format
  ensure_resource( 'package', 'unzip', { 'ensure' => 'present' } )

  $packer_archive_dir = basename($packer_archive)

  archive { "packer_archive_$title":
    path         => "/tmp/${packer_archive_dir}",
    source       => "${archive_uri}/${packer_archive}",
    extract      => true,
    extract_path => $install_dir,
    creates      => "${install_dir}/packer",
    cleanup      => true,
    user         => $user,
    group        => $user,
    require      => File[$install_dir],
  }
}

