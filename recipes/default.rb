#
# Cookbook Name:: weblogic
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_attribute "java"

bea_home = node['weblogic']['bea_home']
java_home = node['java']['java_home']
installer_url = node['weblogic']['installer_url']

if File.exists?(bea_home)
  Chef::Log.info("#{bea_home} already exists.....not installing WebLogic")
else
  Chef::Log.info("#{bea_home} does not exist")

  tmp_dir = "c:\\temp"
  silentxml = "#{tmp_dir}\\silent.xml"

  installer_dir = node['weblogic']['installer_dir']
  installer = "#{installer_dir}\\weblogic.exe"

  directory tmp_dir do
    action :create
  end

  template silentxml do
    source "silent.xml.erb"
  end

  remote_file installer do
    source "#{installer_url}"
    action :create_if_missing
  end

  execute "weblogic" do
    Chef::Log.info("installer=#{installer}")
    command "#{installer} -mode=silent -silent_xml=#{silentxml} -log=#{tmp_dir}\\silent.log"
    action :run
  end

end

nodemgrprops = "#{bea_home}\\wlserver_10.3\\common\\nodemanager\\nodemanager.properties"
template nodemgrprops do
    source "nodemanager.properties.erb"
    notifies :restart, "service[Oracle WebLogic NodeManager (c_bea_wlserver_10.3)]"
end

service "Oracle WebLogic NodeManager (c_bea_wlserver_10.3)"
