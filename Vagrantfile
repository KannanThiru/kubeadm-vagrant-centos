Vagrant.configure("2") do |config|

  config.vm.define "master" do |master|
    master.vm.box = "centos/7"
    master.vm.hostname = 'master'
    master.vm.box_url = "centos/7"
    master.vm.network :private_network, ip: "192.168.56.101"
    master.vm.network "forwarded_port", guest: 6443, host: 6443
    master.vm.provision "shell", inline: "swapoff -a"
    master.vm.synced_folder ".", "/vagrant"

    master.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.memory = 2048
      v.cpus = 2
      v.customize ["modifyvm", :id, "--name", "master"]
    end

    master.vm.provision "shell", path: "install_kubelet.sh"
    master.vm.provision "shell", path: "configure_master.sh"
  end


  config.vm.define "worker1" do |worker1|
    worker1.vm.box = "centos/7"
    worker1.vm.hostname = 'worker1'
    worker1.vm.box_url = "centos/7"
    worker1.vm.network :private_network, ip: "192.168.56.102"
    worker1.vm.provision "shell", inline: "swapoff -a"

    worker1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--name", "worker1"]
    end

    worker1.vm.provision "shell", path: "install_kubelet.sh"
    worker1.vm.provision "shell", path: "configure_worker.sh"
  end

  config.vm.define "worker2" do |worker2|
    worker2.vm.box = "centos/7"
    worker2.vm.hostname = 'worker2'
    worker2.vm.box_url = "centos/7"
    worker2.vm.network :private_network, ip: "192.168.56.103"
    worker1.vm.provision "shell", inline: "swapoff -a"

    worker2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--name", "worker2"]
    end

    worker2.vm.provision "shell", path: "install_kubelet.sh"
    worker2.vm.provision "shell", path: "configure_worker.sh"
  end

end
