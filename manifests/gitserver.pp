class profiles::gitserver (
  $version = 'ce',
) {

  if !($version in [ 'ce', 'ee' ]) {
    $validated_version = 'ce'
  } else {
    $validated_version = $version
  }

  class { 'gitlab':
    external_url => 'http://gitlab.koewacht.net',
    edition      => $validated_version,
  }

}
