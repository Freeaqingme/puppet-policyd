
class policyd::mysql (
  $db_username = $::policyd::db_username,
  $db_password = $::policyd::db_password,
  $db_name     = $::policyd::db_name,
  $db_host     = $::policyd::db_host,
) {

  $sql_path = '/usr/local/share/policyd2/database/'

  include ::mysql

  if $db_host != 'localhost' {
    fail('So far, only local databases are supported')
  }

  exec { 'policyd-mysql':
    command => "/usr/local/bin/bash -c 'for i in core.tsql access_control.tsql quotas.tsql amavis.tsql checkhelo.tsql checkspf.tsql greylisting.tsql; do /usr/local/bin/bash ./convert-tsql mysql \"\$i\" | sed 's/TYPE=InnoDB/ENGINE=InnoDB/g'; done > policyd.mysql.sql'",
    cwd     => $sql_path,
    creates => "${sql_path}/policyd.mysql.sql"
  }

  mysql::grant { $name:   
    mysql_password           => $db_password,
    mysql_user               => $db_username,
    mysql_host               => $db_host,
    mysql_db                 => $db_name,
  }

  mysql::query { 'policyd-mysql-create-db':
    mysql_query => "CREATE DATABASE IF NOT EXISTS ${db_name}"
  }

  mysql::queryfile { 'policyd-mysql-create-db':
    mysql_file => "${sql_path}/policyd.mysql.sql",
    mysql_db   => $db_name,
    require    => [ Mysql::Query['policyd-mysql-create-db'], Exec['policyd-mysql'], Exec['mysqlquery-policyd-mysql-create-db'] ]
  }

}
