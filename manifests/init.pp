#############################################################################
#
# Filename: adminvpn/manifests/init.pp
# Purpose: adminvpn module
# Author: Jim Bagwell
# Date: 2013-03-13
# Revision: 1.0
#
#############################################################################
class adminvpn(
  $localip = $::ipaddress, 
  $vpn_pool = "192.168.0.1", 
  $vpn_pool_mask = "255.255.255.0", 
  $admin_max_clients = 253, 
  $admin_protocol = "tcp", 
  $admin_port = 443, 
  $dns1 = "127.0.0.1", 
  $dns2 = "127.0.0.1"
) {

   include adminvpn::params,
	   adminvpn::base

} #end class 
