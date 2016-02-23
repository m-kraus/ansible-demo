#!/usr/bin/env bash

yum --nogpg -y install epel-release
yum -y install --enablerepo=epel-testing ansible


yum -y install vim tree


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

mkdir -p /omd/sites/$SITE/etc/nagios/conf.d/dynamic
chown -R vagrant: /omd/sites/$SITE/etc/nagios/conf.d/dynamic

omd start $SITE


# copy examples into /home/vagrant (from inside the mgmt node)
cp -a /vagrant/demo/* /home/vagrant
chown -R vagrant:vagrant /home/vagrant

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL

# vagrant environment nodes
10.0.15.10  mgmt
10.0.15.21  web1
10.0.15.22  web2
10.0.15.23  web3
10.0.15.24  web4
10.0.15.25  web5
10.0.15.26  web6
10.0.15.27  web7
10.0.15.28  web8
10.0.15.29  web9
10.0.15.31  app1
10.0.15.32  app2
10.0.15.33  app3
10.0.15.34  app4
10.0.15.35  app5
10.0.15.36  app6
10.0.15.37  app7
10.0.15.38  app8
10.0.15.39  app9
EOL
