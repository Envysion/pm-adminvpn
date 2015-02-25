#############################################################################
#
# Filename: adminvpn/manifests/base.pp
# Purpose: Install and Configure adminvpn
# Author: Jim Bagwell
# Date: 03-13-2013
# Revision: 1.0
#
#############################################################################

class adminvpn::base {

  package { $adminvpn::params::adminvpn_packages:
    ensure  => installed
  }

  file { '/etc/openvpn':
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => Package[$adminvpn::params::adminvpn_packages],
  }

  exec { "openssl dhparam -out dh2048.pem 2048":
    cwd     => "/etc/openvpn",
    creates => "/etc/openvpn/dh2048.pem",
    path    => ["/usr/bin", "/usr/sbin"]
  }

  file { '/etc/openvpn/server.conf':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('adminvpn/server.conf.erb'),
    require => Package[$adminvpn::params::adminvpn_packages],
  }

  augeas { "ip_forward":
    incl    => "/etc/sysctl.conf",
    lens    => "Sysctl.lns",
    changes => "set net.ipv4.ip_forward 1",
    onlyif  => "match net.ipv4.ip_forward != 1",
  } #End augeas ip_forward

  firewall { '0901 accept openvpn on 443':
    ensure => present,
    table  => 'filter',
    chain  => 'INPUT',
    proto  => 'tcp',
    dport  => 443,
    state  => 'NEW',
    action => 'accept',
  }

  service { "openvpn":
    ensure	=> running,
    enable	=> true,
    hasstatus	=> true,
    hasrestart	=> true,
    require	=> File['/etc/openvpn/server.conf'],
  }
}

