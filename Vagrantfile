# This guide is optimized for Vagrant 1.7 and above.
# Although versions 1.6.x should behave very similarly, it is recommended
# to upgrade instead of disabling the requirement below.
Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|

  config.vm.box = "generic/ubuntu2204"

  config.vm.synced_folder ".", "/vagrant", create: true

  # Disable the new default behavior introduced in Vagrant 1.7, to
  # ensure that all Vagrant machines will use the same SSH key pair.
  # See https://github.com/mitchellh/vagrant/issues/5005
  # config.ssh.insert_key = false

  config.vm.provision "ansible_local" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "playbook.yml"
    ansible.raw_arguments = Shellwords.shellsplit(ENV['ANSIBLE_ARGS']) if ENV['ANSIBLE_ARGS']
  end
end
