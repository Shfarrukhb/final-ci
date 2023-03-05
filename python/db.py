import boto3 
 
dynamodb = boto3.client('dynamodb', region_name="ap-northeast-2") 
db_name = input("Enter database name : ") + "-" + input("env : ") 
 
# Create the DynamoDB table. 
def create_db(db_name): 
    if db_name in dynamodb.list_tables()["TableNames"]: 
        print(db_name + " already exists") 
    else:      
        dynamodb.create_table( 
        TableName=db_name, 
        KeySchema=[ 
            { 
                'AttributeName': 'LockID', 
                'KeyType': 'HASH' 
            }, 
        ], 
        AttributeDefinitions=[ 
            { 
                'AttributeName': 'LockID', 
                'AttributeType': 'S' 
            }, 
        ], 
        BillingMode='PAY_PER_REQUEST' 
        ) 
        print(db_name + " table has been created") 
        print(db_name.item_count) 
 
create_db(db_name)