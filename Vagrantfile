# -*- mode: ruby -*-
# vi: set ft=ruby :

HOSTNAME = "#APPNAME#"

Vagrant.configure("2") do |config|
  # toggle virtualbox guest additions installation for faster testing
  # https://github.com/dotless-de/vagrant-vbguest
  config.vbguest.auto_update = true

  config.vm.box = "marcpascual-latest"

  # with the 2nd nic, port forwarding won't be necessary
  # config.vm.network "forwarded_port", guest: 8443, host: 8443

  # first nic is always NAT
  # second can be anything
  # but set both to virtio
  config.vm.network "private_network",
    ip: "192.168.56.#APPIP#",
    netmask: "255.255.255.0",
    dhcp_enabled: false,
    nic_type: "virtio",
    forward_mode: "none"

  config.vm.provider "virtualbox" do |vb|
    vb.name = HOSTNAME
    # dont use a linked clone for template
    # vb.linked_clone = true
    vb.memory = "2048"
    vb.cpus = 2
    # change nic type of eth0 to virtio (defaults to e1000). however this does not
    # get rid of that annoying warning message during vagrant up
    # vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    # set default nic type for this vm
    # https://www.vagrantup.com/docs/virtualbox/configuration.html
    vb.default_nic_type = "virtio"
  end

  # change the hostname
  config.vm.provision "shell", :args => HOSTNAME, inline: <<-SHELL
    hostnamectl set-hostname $1
		sed -i 's/^PasswordAuthentication no$/PasswordAuthentication yes/' /etc/ssh/sshd_config
		systemctl restart sshd
  SHELL

  # make sure that reload plugin is installed first
  # https://stackoverflow.com/questions/34910988/is-it-possible-to-restart-a-machine-when-provisioning-a-machine-using-vagrant-an
  # vagrant plugin install vagrant-reload
  #config.vm.provision :reload

  # install EPEL and all other tools we need
  #config.vm.provision "shell", inline: <<-SHELL
  # rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  # yum -y install jq git wget net-tools telnet vim-enhanced java-1.8.0-openjdk.x86_64
  #SHELL

end
