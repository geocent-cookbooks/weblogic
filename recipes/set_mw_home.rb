#
# Cookbook Name:: weblogic
# Recipe:: set_mw_home
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


ruby_block  "set-env-mw-home" do
  block do
    ENV["MW_HOME"] = node['weblogic']['mw_home']
  end
  not_if { ENV["MW_HOME"] == node['weblogic']['mw_home'] }
end

directory "/etc/profile.d" do
  mode 00755
end

file "/etc/profile.d/weblogic.sh" do
  content "export MW_HOME=#{node['weblogic']['mw_home']}"
  mode 00755
end
