import boto3
def lambda_handler(event, context):
    #uncomment one of the below lines accordingly:
    # updatednslambda()
    # deletednslambda()

    return 'Updated DNS Successfully'

def updatednslambda():
    route53 = boto3.client('route53')
    route53.change_resource_record_sets(
        HostedZoneId='Z36DL2FUSFJ48H',
        ChangeBatch={
            'Changes': [
                {
                    'Action': 'UPSERT',
                    'ResourceRecordSet': {
                        'Name': "john-lambda-dns1.awspreprod.telegraph.co.uk",
                        'Type': 'A',
                        'ResourceRecords': [
                            {
                                'Value': '10.18.183.54'
                            }
                        ],
                        'TTL': 300
                    }
                },
                {
                    'Action': 'UPSERT',
                    'ResourceRecordSet': {
                        'Name': "john-lambda-dns.awspreprod.telegraph.co.uk",
                        'Type': 'CNAME',
                        'SetIdentifier': 'john-lambda-dns1-CNAME',
                        'Weight': 1,
                        'ResourceRecords': [
                            {
                                'Value': 'john-lambda-dns1.awspreprod.telegraph.co.uk'
                            }
                        ],
                        'TTL': 300
                    }
                }
            ]
        }
    )
    
def deletednslambda():
    route53 = boto3.client('route53')
    route53.change_resource_record_sets(
        HostedZoneId='Z36DL2FUSFJ48H',
        ChangeBatch={
            'Changes': [
                {
                    'Action': 'DELETE',
                    'ResourceRecordSet': {
                        'Name': "john-lambda-dns1.awspreprod.telegraph.co.uk",
                        'Type': 'A',
                        'ResourceRecords': [
                            {
                                'Value': '10.18.183.54'
                            }
                        ],
                        'TTL': 300
                    }
                },
                {
                    'Action': 'DELETE',
                    'ResourceRecordSet': {
                        'Name': "john-lambda-dns.awspreprod.telegraph.co.uk",
                        'Type': 'CNAME',
                        'SetIdentifier': 'john-lambda-dns1-CNAME',
                        'Weight': 1,
                        'ResourceRecords': [
                            {
                                'Value': 'john-lambda-dns1.awspreprod.telegraph.co.uk'
                            }
                        ],
                        'TTL': 300
                    }
                }