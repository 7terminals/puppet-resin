class resin::params (
) {
  # Defaults mapped to resin::install.pp

  $ensure               = present
  $user                 = 'root'
  $group                = 'root'
  $install_mode         = 'upstream'
  $install_source       = undef
  $install_destination  = '/opt/resin'

  # Defaults mapped to resin::config.pp

  $config_file_path     = '/opt/resin/conf/resin.xml'
  $config_file_template = 'resin/resin.xml.erb'

  # Defaults mapped to resin::service.pp

  $service_name         = 'resin'
  $service_ensure       = running
  $service_enable       = true
  $service_hasrestart   = true
  $service_subscribe    = Resin::Config['resin']

  # Operating system scpecific configuration


  case $::osfamily {
    'Debian' : {
      $init_script_file_path     = '/etc/init.d/resin'
      $init_script_file_template = 'resin/resin.debian.erb'
    }

    'RedHat' : {
      $init_script_file_path     = '/etc/init.d/resin'
      $init_script_file_template = 'resin/resin.redhat.erb'
    }
    default  : {
      fail("** Error: Module ${module_name} is not supported on ${::osfamily}. It is very simple to extend this module for  ${::osfamily} . Please see documentation here"
      )
    }
  }

}
