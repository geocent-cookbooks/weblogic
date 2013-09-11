
default['weblogic']['owner'] = "vagrant"
default['weblogic']['group'] = "vagrant"

case node['platform_family']

when "debian", "ubuntu"
  default['weblogic']['mw_home'] = "/usr/local/bea"
  default['weblogic']['installer_url'] = nil
  default['weblogic']['nmgr_securelistener'] = "false"
  default['weblogic']['java_flavor'] = "java"
when "rhel", "fedora", "suse"
  default['weblogic']['mw_home'] = "/usr/local/bea"
  default['weblogic']['installer_url'] = nil
  default['weblogic']['nmgr_securelistener'] = "false"
  default['weblogic']['java_flavor'] = "java"
when "mac_os_x", "mac_os_x_server"

when "windows"
  default['weblogic']['ml_home'] = "c:/bea"
  default['weblogic']['wls_install_dir'] = "c:/bea/wlserver_10.3"
  default['weblogic']['installer_url'] = nil
  default['weblogic']['nmgr_securelistener'] = "false"
  default['weblogic']['java_flavor'] = "java"
  default['weblogic']['windows']['package_name'] = "Oracle Weblogic"
end
