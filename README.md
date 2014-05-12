# Puppet module: policyd

This is a Puppet module for policyd based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Dolf Schimmel / TransIP

Official git repository: http://github.com/Freeaqingme/puppet-policyd

So far this module has only been tested on FreeBSD.

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install policyd with default settings

        class { 'policyd': }

* Install a specific version of policyd package

        class { 'policyd':
          version => '1.0.1',
        }

* Disable policyd service.

        class { 'policyd':
          disable => true
        }

* Remove policyd package

        class { 'policyd':
          absent => true
        }

* Enable auditing without without making changes on existing policyd configuration *files*

        class { 'policyd':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'policyd':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'policyd':
          source => [ "puppet:///modules/example42/policyd/policyd.conf-${hostname}" , "puppet:///modules/example42/policyd/policyd.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'policyd':
          source_dir       => 'puppet:///modules/example42/policyd/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'policyd':
          template => 'example42/policyd/policyd.conf.erb',
        }

* Automatically include a custom subclass

        class { 'policyd':
          my_class => 'example42::my_policyd',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'policyd':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'policyd':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'policyd':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'policyd':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-policyd.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-policyd]
