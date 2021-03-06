chef_solo_cookbook_path = ["cookbooks", "site-cookbooks"]
CHEF_CLIENT_INSTALL = <<-EOF
#!/bin/sh
dpkg -l curl|grep -q ^ii || {
  apt-get update
  apt-get install -y curl
}

test -d /opt/chef || {
  echo "Installing chef-client via omnibus"
  curl -L -s https://www.opscode.com/chef/install.sh | bash
}
EOF

# supervisor needs to start after X11, but I don't know how
# to disable autostart from the chef recipe, so just stop
# and restart it after boot here.
$supervisorstart = <<SCRIPT
#!/bin/sh
/etc/init.d/supervisor stop
sleep 5
/etc/init.d/supervisor start
SCRIPT

Vagrant::configure("2") do |config|
  config.vm.box = "box-cutter/ubuntu1404-desktop"

  config.vm.provider "virtualbox" do |v|
    v.gui = true
  end
  
  # Configure Selenium Grid
  config.vm.define :'selenium-grid' do |selenium_grid|
    selenium_grid.vm.network :private_network, ip: "192.168.10.10"
        selenium_grid.vm.hostname = "selenium.local.vm"
        selenium_grid.vm.provider :virtualbox do |vb|
          vb.customize [
                        "modifyvm", :id,
                        "--name", "selenium-grid",
                        "--memory", "1024",
                        "--cpus", 1,
                       ]
        end
      selenium_grid.vm.provision :shell, :inline => CHEF_CLIENT_INSTALL

      selenium_grid.vm.provision :chef_solo do |chef_solo|
        chef_solo.cookbooks_path = chef_solo_cookbook_path
        chef_solo.add_recipe 'selenium-grid::hub'
      end
  end

    # Configure Selenium Node
  config.vm.define :'node1' do |grid_node|
    grid_node.vm.network :private_network, ip: "192.168.10.11"
        grid_node.vm.hostname = "node.selenium.vm"
        grid_node.vm.provider :virtualbox do |vb|
          vb.customize [
                        "modifyvm", :id,
                        "--name", "node1",
                        "--memory", "1024",
                        "--cpus", 1,
                       ]
        end
      grid_node.vm.provision :shell, :inline => CHEF_CLIENT_INSTALL

      grid_node.vm.provision :chef_solo do |chef_solo|
        chef_solo.cookbooks_path = chef_solo_cookbook_path
        chef_solo.add_recipe 'selenium-grid::node'
      end

      grid_node.vm.provision "shell", run: "always", inline: $supervisorstart
  end

#    # Configure Selenium Node
#  config.vm.define :'node2' do |grid_node|
#    grid_node.vm.network :private_network, ip: "192.168.10.12"
#        grid_node.vm.hostname = "node.selenium.vm"
#        grid_node.vm.provider :virtualbox do |vb|
#          vb.customize [
#                        "modifyvm", :id,
#                        "--name", "node2",
#                        "--memory", "512",
#                        "--cpus", 1,
#                       ]
#        end
#      grid_node.vm.provision :shell, :inline => CHEF_CLIENT_INSTALL
#
#      grid_node.vm.provision :chef_solo do |chef_solo|
#        chef_solo.cookbooks_path = chef_solo_cookbook_path
#        chef_solo.add_recipe 'selenium-grid::node'
#      end
#  end
#
#    # Configure Selenium Node
#  config.vm.define :'node3' do |grid_node|
#    grid_node.vm.network :private_network, ip: "192.168.10.13"
#        grid_node.vm.hostname = "node.selenium.vm"
#        grid_node.vm.provider :virtualbox do |vb|
#          vb.customize [
#                        "modifyvm", :id,
#                        "--name", "node3",
#                        "--memory", "512",
#                        "--cpus", 1,
#                       ]
#        end
#      grid_node.vm.provision :shell, :inline => CHEF_CLIENT_INSTALL
#
#      grid_node.vm.provision :chef_solo do |chef_solo|
#        chef_solo.cookbooks_path = chef_solo_cookbook_path
#        chef_solo.add_recipe 'selenium-grid::node'
#      end
#  end
end
