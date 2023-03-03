Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|

  config.vm.define "archlinux" do |archlinux|
    archlinux.vm.box = "generic/arch"
    archlinux.vm.hostname = "archlinux"
    archlinux.vm.network "private_network", ip: "192.168.56.10"

    archlinux.vm.synced_folder ".", "/vagrant", create: true

    archlinux.vm.provision "ansible_local" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "playbook.yml"
      ansible.inventory_path = "hosts.ini"
      ansible.raw_arguments = Shellwords.shellsplit(ENV['ANSIBLE_ARGS']) if ENV['ANSIBLE_ARGS']
    end
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "generic/ubuntu2204"
    ubuntu.vm.hostname = "ubuntu"
    ubuntu.vm.network "private_network", ip: "192.168.56.11"

    ubuntu.vm.synced_folder ".", "/vagrant", create: true

    ubuntu.vm.provision "ansible_local" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "playbook.yml"
      ansible.inventory_path = "hosts.ini"
      ansible.raw_arguments = Shellwords.shellsplit(ENV['ANSIBLE_ARGS']) if ENV['ANSIBLE_ARGS']
    end
  end

end
