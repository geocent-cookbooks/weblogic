#
# Cookbook Name:: weblogic
# Recipe:: zip_distro
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "#{node['weblogic']['java_flavor']}"

Chef::Log.warn("No download url set for weblogic installer.") unless node['weblogic']['installer_url']

src_filename = "wls.zip"
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
extract_path = "#{Chef::Config['file_cache_path']}/weblogic_package"
mw_home = node['weblogic']['mw_home']


case node['platform_family']
when "centos", "rhel", "debian", "ubuntu"

  package "unzip" do
    :install
  end

  directory mw_home do
    recursive true
    owner node['weblogic']['owner']
    group node['weblogic']['group']
    action :create
  end

  remote_file src_filepath do
    source node['weblogic']['installer_url']
  end

  bash 'extract_weblogic' do
    cwd ::File.dirname(src_filepath)
    code <<-EOH
    unzip #{src_filename} -d #{extract_path}
    mv #{extract_path}/* #{mw_home}
    EOH
    not_if { ::File.exists?(extract_path) }
  end

  include_recipe 'weblogic::set_mw_home'

  execute 'give MW_HOME permissions' do
    cwd mw_home
    command "chown -R #{node['weblogic']['owner']}:#{node['weblogic']['group']} #{mw_home}"
  end

  bash 'run weblogic config' do
    cwd mw_home
    command "./configure.sh"
  end

when "windows"
end
