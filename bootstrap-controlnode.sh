#!/usr/bin/env bash

yum --nogpg -y install epel-release

yum -y install vim tree python-pip gcc python-devel sshpass

pip install ansible

su vagrant -c 'ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa'


SITE=monitoring

rpm -Uvh "https://labs.consol.de/repo/testing/rhel7/i386/labs-consol-testing.rhel7.noarch.rpm"
yum -y install omd-2*

# create site
omd create $SITE

# change main settings
omd config $SITE set AUTOSTART on
omd config $SITE set CORE naemon
omd config $SITE set DEFAULT_GUI thruk
omd config $SITE set THRUK_COOKIE_AUTH on
omd config $SITE set NAGVIS_URLS thruk
omd config $SITE set PNP4NAGIOS off

cp -a /vagrant/demo/demo.cfg /omd/sites/$SITE/etc/nagios/conf.d/
cp -a /vagrant/demo/thruk_local.conf /omd/sites/$SITE/etc/thruk/
chown -R $SITE: /omd/sites/$SITE/etc/nagios/conf.d
chown -R $SITE: /omd/sites/$SITE/etc/thruk/

mkdir -p /omd/sites/$SITE/etc/nagios/conf.d/dynamic
chown -R vagrant: /omd/sites/$SITE/etc/nagios/conf.d/dynamic

su $SITE -c 'ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa'
cp -p /home/vagrant/.ssh/id_rsa /omd/sites/$SITE/.ssh/id_rsa_vagrant
cp -p /home/vagrant/.ssh/id_rsa.pub /omd/sites/$SITE/.ssh/id_rsa_vagrant.pub
chown $SITE: /omd/sites/$SITE/.ssh/id_rsa_vagrant*


omd start $SITE


# copy examples into /home/vagrant (from inside the mgmt node)
cp -a /vagrant/demo/* /home/vagrant
chown -R vagrant:vagrant /home/vagrant

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL

# vagrant environment nodes
10.0.15.10  controlnode
10.0.15.21  nodeweb1
10.0.15.22  nodeweb2
10.0.15.23  nodeweb3
10.0.15.24  nodeweb4
10.0.15.25  nodeweb5
10.0.15.26  nodeweb6
10.0.15.27  nodeweb7
10.0.15.28  nodeweb8
10.0.15.29  nodeweb9
10.0.15.31  nodeapp1
10.0.15.32  nodeapp2
10.0.15.33  nodeapp3
10.0.15.34  nodeapp4
10.0.15.35  nodeapp5
10.0.15.36  nodeapp6
10.0.15.37  nodeapp7
10.0.15.38  nodeapp8
10.0.15.39  nodeapp9
EOL
