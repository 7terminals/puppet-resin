define resin::config (
  $config_file_path     = $resin::params::config_file_path,
  $config_file_template = $resin::params::config_file_template,) {
  file { "${config_file_path}":
    ensure  => present,
    path    => $config_file_path,
    content => template($config_file_template),
  }
}
