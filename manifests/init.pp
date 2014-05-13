# = Class: policyd
#
# This is the main policyd class
#
# Firewalling support has not yet been implemented as this module will usually
# run on the same machine as the MTA and not require any firewalling. If this
# is ever changed, it should probably be done in a way that by default it's
# disabled, even if the global firewall settings are set to true. I think(?).
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, policyd class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $policyd_myclass
#
# [*manage_db*]
#   To manage or not to manage the database. That's the question.
#
# [*db_type*]
#   Either SQLite, Pg or mysql. Defaults to SQLite.
#
# [*db_name*]
#   Name of the database you'd like to use
#
# [*db_host*]
#   Host of the database you'd like to use
#
# [*db_username*]
#   Username to connect to the database with
#
# [*db_password*]
#   Password to connect to the database with
#
# [*bypass_mode*]
#   Action to take if no connection can be made with the database.
#   Can be either 'tempfail' or 'pass'.
#
# [*bypass_timeout*]
#   Time to connect to database, in seconds
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, policyd main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $policyd_source
#
# [*source_dir*]
#   If defined, the whole policyd configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $policyd_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $policyd_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, policyd main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $policyd_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $policyd_options
#
# [*service_autorestart*]
#   Automatically restarts the policyd service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $policyd_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $policyd_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $policyd_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $policyd_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for policyd checks
#   Can be defined also by the (top scope) variables $policyd_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $policyd_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $policyd_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $policyd_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $policyd_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $policyd_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: undef
#
# Default class params - As defined in policyd::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of policyd package
#
# [*service*]
#   The name of policyd service
#
# [*service_status*]
#   If the policyd service init script supports status argument
#
# [*process*]
#   The name of policyd process
#
# [*process_args*]
#   The name of policyd arguments. Used by puppi and monitor.
#   Used only in case the policyd process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user policyd runs with.
#
# [*process_group*]
#   The name of the group policyd runs with.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $policyd_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $policyd_protocol
#
#
# See README for usage patterns.
#
class policyd (
  $my_class            = params_lookup( 'my_class' ),
  $db_type             = params_lookup( 'db_type' ),
  $db_name             = params_lookup( 'db_name' ),
  $db_host             = params_lookup( 'db_host' ),
  $db_username         = params_lookup( 'db_username' ),
  $db_password         = params_lookup( 'db_password' ),
  $bypass_mode         = params_lookup( 'bypass_mode' ),
  $bypass_timeout      = params_lookup( 'bypass_timeout' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $noops               = params_lookup( 'noops' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $process_group       = params_lookup( 'process_group' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits policyd::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  $dsn = $policyd::db_type ? {
    'SQLite' => "DBI:SQLite:dbname=${db_name}",
    'Pg'     => "DBI:Pg:database=${db_name};host=${db_host}",
    'mysql'  => "DBI:mysql:database=${db_name};host=${db_host}"
  }

  ### Definition of some variables used in the module
  $manage_package = $policyd::bool_absent ? {
    true  => 'absent',
    false => $policyd::version,
  }

  $manage_service_enable = $policyd::bool_disableboot ? {
    true    => false,
    default => $policyd::bool_disable ? {
      true    => false,
      default => $policyd::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $policyd::bool_disable ? {
    true    => 'stopped',
    default =>  $policyd::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $policyd::bool_service_autorestart ? {
    true    => Service[policyd],
    false   => undef,
  }

  $manage_file = $policyd::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $policyd::bool_absent == true
  or $policyd::bool_disable == true
  or $policyd::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  $manage_audit = $policyd::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $policyd::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $policyd::source ? {
    ''        => undef,
    default   => $policyd::source,
  }

  $manage_file_content = $policyd::template ? {
    ''        => undef,
    default   => template($policyd::template),
  }

  if any2bool($manage_db) {
    if $db_type == 'mysql' {
      include ::policyd::mysql
    } else {
      fail('$manage_db is currently only supported with Mysql')
    }
  }

  user { $policyd::process_user:
    ensure => present,
    system => true
  }

  ### Managed resources
  package { $policyd::package:
    ensure  => $policyd::manage_package,
    noop    => $policyd::noops,
  }

  service { 'policyd':
    ensure     => $policyd::manage_service_ensure,
    name       => $policyd::service,
    enable     => $policyd::manage_service_enable,
    hasstatus  => $policyd::service_status,
    pattern    => $policyd::process,
    require    => Package[$policyd::package],
    noop       => $policyd::noops,
  }

  file { 'policyd.conf':
    ensure  => $policyd::manage_file,
    path    => $policyd::config_file,
    mode    => $policyd::config_file_mode,
    owner   => $policyd::config_file_owner,
    group   => $policyd::config_file_group,
    require => Package[$policyd::package],
    notify  => $policyd::manage_service_autorestart,
    source  => $policyd::manage_file_source,
    content => $policyd::manage_file_content,
    replace => $policyd::manage_file_replace,
    audit   => $policyd::manage_audit,
    noop    => $policyd::noops,
  }

  # The whole policyd configuration directory can be recursively overriden
  if $policyd::source_dir {
    file { 'policyd.dir':
      ensure  => directory,
      path    => $policyd::config_dir,
      require => Package[$policyd::package],
      notify  => $policyd::manage_service_autorestart,
      source  => $policyd::source_dir,
      recurse => true,
      purge   => $policyd::bool_source_dir_purge,
      force   => $policyd::bool_source_dir_purge,
      replace => $policyd::manage_file_replace,
      audit   => $policyd::manage_audit,
      noop    => $policyd::noops,
    }
  }


  ### Include custom class if $my_class is set
  if $policyd::my_class {
    include $policyd::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $policyd::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'policyd':
      ensure    => $policyd::manage_file,
      variables => $classvars,
      helper    => $policyd::puppi_helper,
      noop      => $policyd::noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $policyd::bool_monitor == true {
    if $policyd::port != '' {
      monitor::port { "policyd_${policyd::protocol}_${policyd::port}":
        protocol => $policyd::protocol,
        port     => $policyd::port,
        target   => $policyd::monitor_target,
        tool     => $policyd::monitor_tool,
        enable   => $policyd::manage_monitor,
        noop     => $policyd::noops,
      }
    }
    if $policyd::service != '' {
      monitor::process { 'policyd_process':
        process  => $policyd::process,
        service  => $policyd::service,
        pidfile  => $policyd::pid_file,
        user     => $policyd::process_user,
        argument => $policyd::process_args,
        tool     => $policyd::monitor_tool,
        enable   => $policyd::manage_monitor,
        noop     => $policyd::noops,
      }
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $policyd::bool_debug == true {
    file { 'debug_policyd':
      ensure  => $policyd::manage_file,
      path    => "${settings::vardir}/debug-policyd",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $policyd::noops,
    }
  }

}
