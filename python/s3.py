import boto3 
import time 
 
region = 'us-east-1' 
bucket_name = input("Enter bucket name : ") + "-" + input("env : ") 
s3_list = [] 
 
s3_client = boto3.client('s3', region_name=region) 
 
s3_resource = boto3.resource('s3', region_name=region) 
 
#get the list of all buckets 
for bucket in s3_client.list_buckets()['Buckets']: 
       s3_list.append(bucket["Name"]) 
 
#function to create bucket 
def create_bucket(bucket_name, region): 
    if bucket_name in s3_list: 
        print("Bucket already exists") 
    else: 
        location = {'LocationConstraint': region} 
        s3_client.create_bucket(Bucket=bucket_name, 
        CreateBucketConfiguration=location) 
        print(f' Bucket {bucket_name} has been created') 
        time.sleep(5) 
 
        #enable bucket versioning 
        s3_resource.BucketVersioning(bucket_name).enable() 
 
        #enable server side encryption 
        s3_client.put_bucket_encryption( 
            Bucket=bucket_name, 
            ServerSideEncryptionConfiguration={ 
            "Rules": [ 
                    {"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}} 
                    ] 
            }, 
        ) 
        #set the public block 
        s3_client.put_public_access_block( 
            Bucket=bucket_name, 
            PublicAccessBlockConfiguration={ 
            'BlockPublicAcls': True, 
            'IgnorePublicAcls': True, 
            'BlockPublicPolicy': True, 
            'RestrictPublicBuckets': False 
            } 
        ) 
 
create_bucket(bucket_name, region)