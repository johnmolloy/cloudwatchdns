export AWS_DEFAULT_REGION=eu-west-1

SERVER=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
BUSYWORKERS=`wget -q -O - http://localhost/server-status?auto | grep BusyWorkers | awk '{ print $2 }'`
IDLEWORKERS=`wget -q -O - http://localhost/server-status?auto | grep IdleWorkers | awk '{ print $2 }'`

aws cloudwatch put-metric-data --metric-name johntest-busyworkers --namespace "EC2: HTTPD" --dimensions "InstanceId=$SERVER" --unit Count --value $BUSYWORKERS
aws cloudwatch put-metric-data --metric-name johntest-idleworkers --namespace "EC2: HTTPD" --dimensions "InstanceId=$SERVER" --unit Count --value $IDLEWORKERS
