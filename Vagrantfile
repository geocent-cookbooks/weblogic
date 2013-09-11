# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :test_win do |test_win|
    test_win.vm.box = "windows-7-enterprise"
    test_win.vm.network :private_network, ip: "33.33.33.10"

    test_win.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    test_win.windows.halt_timeout = 15
    test_win.vm.guest = :windows
    test_win.winrm.max_tries = 30
    test_win.winrm.timeout = 1800
    test_win.winrm.username = "vagrant"
    test_win.winrm.password = "vagrant"
    test_win.vm.network :forwarded_port, guest: 3389, host: 3389
    test_win.vm.network :forwarded_port, guest: 5985, host: 5985

    test_win.berkshelf.enabled = true
    test_win.vm.provision :chef_solo do |chef|
      chef.json = {
        :jrockit => {
          :windows => {
            :url => "c:/vagrant/jrockit-jdk1.6.0_29-R28.2.2-4.1.0-windows-ia32.exe"
          },
          :java_home => "C:/Java/JRockitJDK28.2.2",
          :jre_home => "C:/Java/JRockitJDK28.2.2_Jrmc"
          },
        :weblogic => {
          :installer_url => "c:/vagrant/wls1033_oepe111150_win32.exe",
          :java_home => "C:/Java/JRockitJDK28.2.2",
          :java_flavor => "jrockit"
        }
      }

      chef.run_list = [
          "recipe[weblogic]"
      ]
    end
  end


  config.vm.define :test_ubuntu do |test_ubuntu|
    test_ubuntu.vm.hostname = "test-ubuntu"
    test_ubuntu.vm.box = "opscode_ubuntu-12.04_provisionerless"
    test_ubuntu.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"
    test_ubuntu.vm.network :private_network, ip: "33.33.33.21"
    test_ubuntu.omnibus.chef_version = "11.4.0"

    test_ubuntu.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end

    test_ubuntu.vm.provision :chef_solo do |chef|

      chef.json = {
        :weblogic => {
          :installer_url => 'http://33.33.33.1:8000/wls1034_dev.zip',
        }
      }

      chef.data_bags_path = "data_bags"
      chef.run_list = [
        "recipe[apt]",
        "recipe[weblogic::zip_distro]"
      ]
    end
  end

  config.vm.define :test_centos do |box|
    box.vm.hostname = "test-centos"
    #box.vm.box = "opscode_centos-5.9_chef-11.4.0.box"
    box.vm.box = "opscode_centos-6.4_chef-11.4.4"
    #box.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-5.9_provisionerless.box"
    box.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-6.4_chef-11.4.4.box"
    box.vm.network :private_network, ip: "33.33.33.21"
    box.vm.network :forwarded_port, guest: 6001, host:6001
    #box.omnibus.chef_version = "11.4.0"

    box.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    box.vm.provision :chef_solo do |chef|

      chef.json = {
        :weblogic => {
          :installer_url => 'http://33.33.33.1:8000/wls1034_dev.zip',
        }
      }

      chef.data_bags_path = "data_bags"
      chef.run_list = [
        "recipe[yum]",
        "recipe[weblogic::zip_distro]"
      ]
    end
  end



end
