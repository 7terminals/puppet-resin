define resin::service (
  $init_script_file_path     = undef,
  $init_script_file_template = undef,
  $service_name              = undef,
  $service_ensure            = undef,
  $service_enable            = undef,
  $service_hasrestart        = undef,
  $service_subscribe         = undef,) {
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
    subscribe  => $service_subscribe,
  }

}
