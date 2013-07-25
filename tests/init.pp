resin { 'resin':
  user  => 'francis',
  group => 'francis',
  install_source            => 'puppet:///modules/resin/resin-4.0.36.tar.gz',
  install_destination       => '/opt/resin',
  config_file_path          => '/opt/resin/conf/resin.xml',
  config_file_template      => 'resin/resin.xml.erb',
  init_script_file_path     => '/etc/init.d/resin',
  init_script_file_template => 'resin/resin',
  service_name              => 'resin',
  service_ensure            => running,
  service_enable            => true,
  service_hasrestart        => true,
  service_subscribe         => undef,
  noop  => true,
}
