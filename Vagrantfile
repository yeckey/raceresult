# # # # # # # # # # # # # # # #
# tavcc development base box  #
# # # # # # # # # # # # # # # #

Vagrant.configure(2) do |config|
  # Define the display name of this Vagrant box
  config.vm.define "dev"

  # Use Docker as virtualization provider
  config.vm.provider "docker" do |docker|
    docker.build_dir = "." # Dockerfile is at the same location as Vagrantfile
    docker.has_ssh = true  # The underlying Docker container provides SSH access
  end

  # Use /bin/sh for provisioning as Alpine Linux doesn't provide bash by default
  config.ssh.shell = "/bin/sh"
  # Enable SSH agent forwarding for easy GitHub integration
  config.ssh.forward_agent = true

  # Disable default /vagrant share and use /vagrant/#{project_name} instead
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/vagrant/#{File.split(Dir.getwd)[-1]}"

  # Change vagrant user id according to current host user
  # config.vm.provision "shell", inline: "usermod -u #{%x(id -u).chomp} vagrant"
  # Copy the host's git configuration to the box
  config.vm.provision "shell", inline: "echo -e '#{File.read("#{Dir.home}/.gitconfig")}' > '/home/vagrant/.gitconfig'"
  # Automatically switch to the project root when logging in
  config.vm.provision "shell", inline: "echo 'cd /vagrant/#{File.split(Dir.getwd)[-1]}' >> /home/vagrant/.zshrc"
end
