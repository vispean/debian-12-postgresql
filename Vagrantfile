Vagrant.configure("2") do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.define "primary" do |primary|
    primary.vm.box = "loch-tech/debian-12-bookworm-ch"
    primary.vm.network "private_network", ip: "192.168.56.10"

    primary.vm.provider "virtualbox" do |vb|
      vb.name = "debian-12-postgresql-primary"
      #vb.gui = true
      #vb.memory = "4096"
      vb.customize ["modifyvm", :id, "--vram", "128"]
    end

    primary.vm.provision "shell", path: "scripts/postgresql.sh"
    primary.vm.provision "shell", path: "scripts/postgresql_primary_node.sh"
  end

  config.vm.define "replica" do |replica|
    replica.vm.box = "loch-tech/debian-12-bookworm-ch"
    replica.vm.network "private_network", ip: "192.168.56.11"

    replica.vm.provider "virtualbox" do |vb|
      vb.name = "debian-12-postgresql-replica"
      #vb.gui = true
      #vb.memory = "4096"
      vb.customize ["modifyvm", :id, "--vram", "128"]
    end

    replica.vm.provision "shell", path: "scripts/postgresql.sh"
    replica.vm.provision "shell", path: "scripts/postgresql_replica_node.sh"
  end
end
