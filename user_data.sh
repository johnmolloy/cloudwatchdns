#!/bin/bash
yum install -y git
cd /home/ec2-user/
git clone https://github.com/johnmolloy/cloudwatchdns.git
chmod a+x /home/ec2-user/cloudwatchdns/cloudwatchmetric.sh
chmod a+x /home/ec2-user/cloudwatchdns/launch_script.sh
cd /home/ec2-user/cloudwatchdns
./launch_script.sh