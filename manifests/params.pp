#############################################################################
#
# Filename: adminvpn/manifests/params.pp
# Purpose: Parameters for the adminvpn class
# Author: Jim Bagwell
# Date: 03/13/2013
# Revision: 1.0
#
#############################################################################
class adminvpn::params {

  $adminvpn_packages = ['openvpn', 'lzo', 'pkcs11-helper']
  $localip = $adminvpn::localip
  $vpn_pool = $adminvpn::vpn_pool
  $vpn_pool_mask = $adminvpn::vpn_pool_mask
  $admin_max_clients = $adminvpn::admin_max_clients
  $admin_protocol = $adminvpn::admin_protocol
  $admin_port = $adminvpn::admin_port
} #End class adminvpn::params
