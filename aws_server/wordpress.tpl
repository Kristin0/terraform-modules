#!/bin/bash -ex
apt update -y
apt install git -y
mkdir -p /home/ubuntu/ec2
cd /home/ubuntu/ec2
git init
git pull https://github.com/Kristin0/epam-training-ec2.git
chown -R ubuntu:ubuntu /home/ubuntu/ec2
runuser -l ubuntu -c 'cd ~/ec2/ansible && ansible-playbook wordpress.yml -e "mysql_root_user=${rds_admin_username} mysql_login_host=${rds_login_host} mysql_root_password=${rds_admin_password}'