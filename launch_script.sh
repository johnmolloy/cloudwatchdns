#!/bin/bash
yum install -y httpd
cd /var/www/html/
wget http://i.imgur.com/VuofKvO.jpg
echo "<html><div align="center"><h1>Webpage Test</h1></div>
<img src="VuofKvO.jpg" alt="Lord Buckethead"></html>" > /var/www/html/index.html 
cat >>/etc/httpd/conf/httpd.conf <<EOL
<Location /server-status>
    SetHandler server-status
    Order allow,deny
    Allow from all
</Location>
EOL
chkconfig httpd on
service httpd start
cd /home/ec2-user

echo "*/1 * * * * ec2-user /home/ec2-user/cloudwatchdns/cloudwatchmetric.sh" > /etc/cron.d/cloudwatchmetric

SERVER=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
UPALARMNAME="scale-up-alarm-"
UPALARMNAME+=$SERVER
DOWNALARMNAME="scale-down-alarm-"
DOWNALARMNAME+=$SERVER
echo $SERVER
echo $UPALARMNAME
echo $DOWNALARMNAME
export AWS_DEFAULT_REGION=eu-west-1
aws cloudwatch put-metric-alarm --alarm-name $UPALARMNAME --comparison-operator GreaterThanThreshold --evaluation-periods 1 --metric-name johntest-busyworkers --namespace "johntest" --dimensions "Name=InstanceId,Value=$SERVER" --period 600 --statistic Average --threshold 10 --alarm-actions arn:aws:autoscaling:eu-west-1:540421644628:scalingPolicy:e3bbf3e1-d3ed-4d8c-930e-be4d1ef6dc39:autoScalingGroupName/john-test:policyName/john-test-ScaleOut
aws cloudwatch put-metric-alarm --alarm-name $DOWNALARMNAME --comparison-operator LessThanThreshold --evaluation-periods 1 --metric-name johntest-busyworkers --namespace "johntest" --dimensions "Name=InstanceId,Value=$SERVER" --period 600 --statistic Average --threshold 9 --alarm-actions arn:aws:autoscaling:eu-west-1:540421644628:scalingPolicy:41bbdceb-deef-4c3e-b6bf-8b43d7e8018d:autoScalingGroupName/john-test:policyName/john-test-ScaleIn