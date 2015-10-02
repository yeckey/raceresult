# # # # # # # # # # # # # # # # #
# tavcc development base image  #
# # # # # # # # # # # # # # # # #
FROM alpine
MAINTAINER WhyEee <whyeee@tav.cc>

# Install system packages
RUN apk add --update \
      sudo curl nano htop less build-base \
      openssh git zsh mc

# Create Vagrant user
RUN adduser -D vagrant -s /bin/zsh && \
    echo -n 'vagrant:vagrant' | chpasswd && \
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant && \
    mkdir -p /home/vagrant/.ssh && \
    chown -R vagrant: /home/vagrant/.ssh && \
    curl -sL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/vagrant/.ssh/authorized_keys

# Setup SSH environment
RUN ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -q -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa && \
    echo -e "You are now working on a Vagrant box\n" > /etc/motd

# Install and customize oh-my-zsh
RUN sudo -u vagrant sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &> /dev/null || true && \
    mkdir /home/vagrant/.oh-my-zsh/custom/themes && \
    curl -sL https://gist.githubusercontent.com/WhyEee/1546aab228f5879d0b20/raw/18203ef30f1fe37ee1c4c2f95c76829665944400/aliases.zsh > /home/vagrant/.oh-my-zsh/custom/aliases.zsh && \
    curl -sL https://gist.githubusercontent.com/WhyEee/1546aab228f5879d0b20/raw/18203ef30f1fe37ee1c4c2f95c76829665944400/robbyrussell.zsh-theme > /home/vagrant/.oh-my-zsh/custom/themes/robbyrussell.zsh-theme

# Install ruby environment
RUN apk add --update \
      ruby ruby-dev ruby-irb ruby-bundler \
      ruby-nokogiri ruby-sqlite nodejs tzdata && \
    echo "gem: --no-document --user-install" > /home/vagrant/.gemrc && \
    echo $'PATH="$(ruby -rubygems -e \'puts Gem.user_dir\')/bin:$PATH"' >> /home/vagrant/.zshrc

# Define SSH as the Docker container's main process
EXPOSE 22
CMD /usr/sbin/sshd -D
