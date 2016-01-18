define systemd::service (
                          $execstart,
                          $restart='always',
                          $user='root',
                          $group='root',
                          $servicename=$name,
                          $forking=false,
                        ) {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if ! defined(Class['systemd'])
  {
    fail('You must include the systemd base class before using any systemd defined resources')
  }

  file { "/etc/systemd/system/${servicename}.service":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/service.erb"),
    notify  => Exec['systemctl reload'],
  }

}
