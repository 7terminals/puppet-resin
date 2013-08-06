define resin::service (
  $init_script_file_path     = $resin::params::init_script_file_path,
  $init_script_file_template = $resin::params::init_script_file_template,
  $service_name              = $resin::params::service_name,
  $service_ensure            = $resin::params::service_ensure,
  $service_enable            = $resin::params::service_enable,
  $service_hasrestart        = $resin::params::service_hasrestart,
  $service_hasstatus         = $resin::params::service_hasstatus,
  $service_subscribe         = $resin::params::service_subscribe) {
  file { $init_script_file_path:
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0755,
    content => template($init_script_file_template),
  }

  service { $service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasrestart => $service_hasrestart,
    hasstatus  => $service_hasstatus,
    subscribe  => $service_subscribe,
  }

}
