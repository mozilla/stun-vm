class stun-server {
  include daemontools
  $stun_rpm = 'stun-server-0.96-6svc.amzn1.x86_64.rpm'

  file {
    "/var/tmp/${stun_rpm}":
      ensure => present,
      source => "puppet:///modules/${module_name}/${stun_rpm}",
  }

  package {
    'stun-server':
      ensure   => installed,
      provider => 'rpm',
      source   => "file:///var/tmp/${stun_rpm}",
      require  => File["/var/tmp/${stun_rpm}"],
  }

  daemontools::setup {
    'stun-server':
      require => Package['stun-server'];
  }
}
