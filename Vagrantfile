# -*- mode: ruby -*-
# vi: set ft=ruby :

build_script = <<__SCRIPT__
sudo service iptables stop
sudo chkconfig iptables off

sudo cp -a /usr/share/zoneinfo/Japan /etc/localtime

sudo rpm -Uhv http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
sudo rpm -Uhv http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo rpm -Uvh http://apt.sw.be/redhat/el5/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
sudo perl -i.bak -pe 's!^\s*enabled\s*=\s*0!enabled=1!' /etc/yum.repos.d/remi.repo
sudo sed -i -e 's/el5/el6/g' /etc/yum.repos.d/rpmforge.repo
sudo sed -i -e 's/#baseurl/baseurl/g' /etc/yum.repos.d/epel.repo
sudo sed -i -e 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/epel.repo
sudo wget http://www.hop5.in/yum/el6/hop5.repo -O /etc/yum.repos.d/hop5.repo
sudo yum clean all
sudo yum upgrade -y && sudo yum update -y
__SCRIPT__

Vagrant::Config.run do |config|
  config.vm.box = 'sop'
  config.vm.box_url = 'http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.3-x86_64-v20130101.box'

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui
  config.vm.network :hostonly, '192.168.33.15'
  config.vm.forward_port 80, 80
  config.vm.forward_port 3306, 3306
  config.vm.share_folder 'v-data', '/app', '~/proj/hhvm-sop'

  #config.vm.provision :shell, :inline => build_script
  #config.vm.provision :shell, :path => './provisioners/hhvm.sh'
  #config.vm.provision :shell, :path => './provisioners/php.sh'
end
