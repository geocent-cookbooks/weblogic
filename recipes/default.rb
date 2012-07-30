#
# Cookbook Name:: weblogic
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform?("ubuntu","debian","redhat","centos","fedora","scientific","amazon")
  Chef::Log.debug("unix platform")

  #unix
  ark "weblogic" do
     url 'http://someurl.example.com/weblogic.tar.gz'
     version '10.3'        
     checksum '89ba5fde0c596db388c3bbd265b63007a9cc3df3a8e6d79a46780c1a39408cb5'
  end

  execute "weblogic" do
    #run bin file from ark download
    command "weblogic.bin"
    #creates "/var/lib/slapd/uid.bdb"
    action :run
  end
else 
  Chef::Log.debug("windows platform")
  #windows
  windows_package "weblogic" do
    source "http://someurl.example.com/weblogic.exe"
    action :install
  end
end
