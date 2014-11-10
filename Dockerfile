# Base Vagrant box

FROM ubuntu:14.04

#Optional, update mirrors speedups updates, but some mirrors sometimes fail
#RUN sed -i -e 's,http://[^ ]*,mirror://mirrors.ubuntu.com/mirrors.txt,' /etc/apt/sources.list

#update apt sources
RUN apt-get update --fix-missing

# Optional, upgrade to latest (takes a while), but before install sshd
RUN apt-get upgrade -y

#install required packages
RUN apt-get install -y apt-utils openssh-server sudo curl wget nfs-common && \
    apt-get clean #cleanup to reduce image size

# Create and configure vagrant user
RUN useradd --create-home -s /bin/bash vagrant
WORKDIR /home/vagrant

# Configure SSH access
RUN mkdir -p /home/vagrant/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant: /home/vagrant/.ssh && \
    adduser vagrant sudo && \
    `# Enable passwordless sudo for users under the "sudo" group` && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers && \
    echo -n 'vagrant:vagrant' | chpasswd && \
    `# Thanks to http://docs.docker.io/en/latest/examples/running_ssh_service/` && \
    mkdir /var/run/sshd

# Puppet
RUN wget http://apt.puppetlabs.com/puppetlabs-release-stable.deb -O /tmp/puppetlabs-release-stable.deb && \
    dpkg -i /tmp/puppetlabs-release-stable.deb && \
    apt-get update && \
    apt-get install puppet puppet-common hiera facter virt-what lsb-release  -y --force-yes && \
    rm -f /tmp/*.deb && \
    apt-get clean

# Optional Chef
#RUN curl -L https://www.opscode.com/chef/install.sh -k | bash && apt-get clean

# Expose port 22 for ssh
EXPOSE 22

#leave the SHH daemon (and container) running
CMD /usr/sbin/sshd -D