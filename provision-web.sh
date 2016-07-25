#!/usr/bin/env bash

yum -y install rsync perl-core httpd

systemctl start httpd
systemctl enable httpd
