#
# Author:: Nick Dobson
# Cookbook Name:: weblogic
# Recipe:: default
#
# Copyright 2013, Nick Dobson
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "#{node['weblogic']['java_flavor']}"

if platform?("windows")

  Chef::Log.warn("No download url set for weblgoic installer.") unless node['weblogic']['installer_url']

  tmp_dir = "#{Chef::Config[:file_cache_path]}"
  bea_home = node['weblogic']['bea_home']

  template "#{tmp_dir}/weblogic-silent.xml" do
    source "silent.xml.erb"
  end
  
  windows_package node['weblogic']['windows']['package_name'] do
        source node['weblogic']['installer_url']
        action :install
        installer_type :custom
        options "-mode=silent -silent_xml=\"#{tmp_dir}/weblogic-silent.xml\" -log=\"#{tmp_dir}/weblogic-silent.log\""
  end

  nodemgrprops = "#{bea_home}\\wlserver_10.3\\common\\nodemanager\\nodemanager.properties"
  template nodemgrprops do
    source "nodemanager.properties.erb"
    notifies :restart, "service[Oracle WebLogic NodeManager (c_bea_wlserver_10.3)]"
  end

end

service "Oracle WebLogic NodeManager (c_bea_wlserver_10.3)"
