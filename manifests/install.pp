define resin::install (
  $ensure              = $resin::params::ensure,
  $user                = $resin::params::user,
  $group               = $resin::params::group,
  $install_mode        = $resin::params::install_mode,
  $install_source      = $resin::params::install_source,
  $install_build_dir   = "${settings::vardir}/${name}-working",
  $install_destination = $resin::params::install_destination,) {
  if $install_mode != 'upstream' {
    fail('This module only supports Resin installation from upstream provider')
  }

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', }

  file { $install_build_dir:
    ensure => directory,
    path   => $install_build_dir,
  }

  if !('.tar.gz' in $install_source) {
    fail('source must be a .tar.gz archive downloaded from http://www.caucho.com/download/')
  }

  file { "${install_build_dir}/resin.tar.gz":
    ensure  => present,
    path    => "${install_build_dir}/resin.tar.gz",
    source  => $install_source,
    owner   => root,
    group   => root,
    require => File["${install_build_dir}"],
  }

  exec { "extract_${name}":
    cwd     => $install_build_dir,
    command => 'mkdir extracted; tar -C extracted -xzf resin.tar.gz; touch .resin_extracted',
    creates => "${install_build_dir}/.resin_extracted",
    require => File["${install_build_dir}/resin.tar.gz"],
  }

  file { "${install_destination}":
    ensure  => directory,
    path    => $install_destination,
    owner   => $user,
    group   => $group,
    require => Exec["extract_${name}"],
  }

  exec { "move_${name}_to_destination":
    cwd     => $install_build_dir,
    command => "cp -R extracted/resin*/* ${install_destination}/",
    creates => "${install_destination}/lib/resin.jar",
    require => File["${install_destination}"],
  }
}
