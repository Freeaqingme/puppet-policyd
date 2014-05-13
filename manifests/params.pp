# Class: policyd::params
#
# This class defines default parameters used by the main module class policyd
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to policyd class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class policyd::params {

  ### Application related parameters
  $db_type        = 'SQLite'
  $db_name        = 'policyd'
  $db_host        = 'localhost'
  $db_username    = 'policyd'
  $db_password    = fqdn_rand(999991337, $name)
  $bypass_mode    = 'tempfail'
  $bypass_timeout = 30
  $manage_db      = true

  $package = $::operatingsystem ? {
    /(?i:FreeBSD)/ => 'mail/policyd2',
    /(?i:Debian)/  => 'postfix-cluebringer',
    default        => 'policyd2',
  }

  $service = $::operatingsystem ? {
    default => 'policyd2',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'perl',
  }

  $process_args = $::operatingsystem ? {
    /(?i:FreeBSD)/ => 'cbpolicyd',
    default        => 'policyd',
  }

  $process_user = $::operatingsystem ? {
    default => 'policyd',
  }

  $process_group = $::operatingsystem ? {
    default => 'mail',
  }

  $config_dir = $::operatingsystem ? {
    /(?i:FreeBSD)/ => '/usr/local/etc/cluebringer.d/',
    default        => '/etc/cluebringer.d' # Todo check Debian defaults
  }

  $config_file = $::operatingsystem ? {
    /(?i:FreeBSD)/ => '/usr/local/etc//cluebringer.conf',
    default        => '/etc/policyd/policyd.conf' # Todo check Debian defaults
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    /(?i:FreeBSD)/ => 'wheel',
    default        => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/policyd',
    default                   => '/etc/sysconfig/policyd',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:FreeBSD)/            => '/var/run/cbpolicyd.pid',
    default                   => '/var/run/policyd.pid' # TODO
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/policyd',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/policyd',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/policyd/policyd.log',
  }

  $port = '10031'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'policyd/cluebringer.conf.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = '127.0.0.1'
  $firewall = false
  $firewall_tool = ''
  $firewall_src = ''
  $firewall_dst = ''
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = undef

}
