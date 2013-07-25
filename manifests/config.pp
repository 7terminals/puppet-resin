define resin::config (
  $config_file_path     = undef,
  $config_file_template = undef,) {
  if config_file_template == undef {
    fail('Parameter \'config_file_template\' must be a template in the templates directory of the module')
  }

  file { "${config_file_path}":
    ensure  => present,
    path    => $config_file_path,
    content => template($config_file_template),
  }
}
