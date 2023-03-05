import boto3 
import os
 
dynamodb = boto3.client('dynamodb', region_name="us-east-1") 
table_name = os.getenv('db_table_name')

# Create the DynamoDB table. 
def create_db(table_name): 
    if table_name in dynamodb.list_tables()["TableNames"]: 
        print(table_name + " already exists") 
    else:      
        print(f'::set-output name=db_chr::{None}')
create_db(table_name)