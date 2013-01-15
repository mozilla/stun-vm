define daemontools::setup ($module = 'daemontools') {
    include daemontools::base

    $svc_path = "${module}/daemontools"

    file {
        "/service/${name}":
            ensure  => link,
            target  => "/var/services/${name}",
            require => [
                File["/var/services/${name}"],
                File["/var/services/${name}/log/run"],
            ];
        "/var/log/services/${name}":
            ensure  => directory,
            owner   => 'root',
            group   => 'root',
            mode    => '0755',
            require => [
                File['/var/log/services'],
            ];
        "/var/services/${name}/supervise":
            ensure  => directory,
            owner   => 'root',
            group   => 'root',
            mode    => '0755',
            require => File["/var/services/${name}"];
        "/var/services/${name}/log":
            ensure  => "../../../var/log/services/${name}",
            require => [
                File["/var/services/${name}"],
                File["/var/log/services/${name}"],
            ];
        "/var/services/${name}/log/run":
            ensure  => file,
            owner   => 'root',
            group   => 'root',
            mode    => '0755',
            content => template('daemontools/log-run'),
            require => File["/var/services/${name}/log"];
        "/var/services/${name}/run":
            ensure  => file,
            owner   => 'root',
            group   => 'root',
            source  => [
                "puppet:///modules/${svc_path}/${name}.${::fqdn}/run",
                "puppet:///modules/${svc_path}/${name}.${::environment}/run",
                "puppet:///modules/${svc_path}/${name}/run",
                ],
            require => File['/var/services'];
        "/var/services/${name}":
            ensure  => directory,
            recurse => true,
            purge   => false,
            force   => true,
            links   => manage,
            replace => true,
            owner   => 'root',
            group   => 'root',
            source  => [
                "puppet:///modules/${svc_path}/${name}.${::fqdn}",
                "puppet:///modules/${svc_path}/${name}.${::environment}",
                "puppet:///modules/${svc_path}/${name}",
                ],
            ignore  => [
                '.svn',
                'supervise',
                '.*.swp',
            ],
            require => File['/var/services'];
    }

    exec {
      "svc-restart-${name}":
        command     => "/usr/local/bin/svc -t /service/${name}",
        require     => File["/service/${name}"],
        refreshonly => true;
    }

    exec {
      "svc-force-restart-${name}":
        command     => "/usr/local/bin/svc -k /service/${name}",
        require     => File["/service/${name}"],
        refreshonly => true;
    }
}
