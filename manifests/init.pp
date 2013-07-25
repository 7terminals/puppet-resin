# Class: resin
#
# This module manages resin
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
define resin (
  $ensure = present,
  $user   = 'root',
  $group  = 'root',
  $install_mode              = 'upstream',
  $install_source            = undef,
  $install_build_dir         = "${$settings::vardir}/${name}-working",
  $install_destination       = '/opt/resin',
  $config_file_path          = "${::install_destination}/conf/resin.xml",
  $config_file_template      = undef,
  $init_script_file_path     = "/etc/init.d/${name}",
  $init_script_file_template = undef,
  $service_name              = undef,
  $service_ensure            = running,
  $service_enable            = true,
  $service_hasrestart        = true,
  $service_subscribe         = Resin::Config[$name],
  $noop   = false,) {
  # Install
  resin::install { $name:
    ensure              => $ensure,
    user                => $user,
    group               => $group,
    install_mode        => $install_mode,
    install_source      => $install_source,
    install_build_dir   => $install_build_dir,
    install_destination => $install_destination,
    noop                => $noop
  }

  # Config
  resin::config { $name:
    config_file_path     => $config_file_path,
    config_file_template => $config_file_template,
    noop                 => $noop,
    require              => Resin::Install[$name],
  }

  # Service
  resin::service { $name:
    init_script_file_path     => $init_script_file_path,
    init_script_file_template => $init_script_file_template,
    service_name   => $service_name,
    service_ensure => $service_ensure,
    service_enable => $service_enable,
    service_hasrestart        => $service_hasrestart,
    service_subscribe         => $service_subscribe,
    noop           => $noop,
    require        => Resin::Config[$name],
  }
}

