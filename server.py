import os
from fastapi import FastAPI
import boto3


app = FastAPI()


@app.get("/ec2")
async def root():
    access_key = os.getenv("access_key")
    secret_key = os.getenv("secret_key")
    client = boto3.client('ec2', aws_access_key_id=access_key, aws_secret_access_key=secret_key,
                                    region_name='ap-south-1')

    ec2_regions = ['ap-south-1']
    details = []
    for region in ec2_regions:
        conn = boto3.resource('ec2', aws_access_key_id=access_key, aws_secret_access_key=secret_key,
                    region_name=region)
        instances = conn.instances.filter()
        for instance in instances:
            if instance.state["Name"] == "running":
                print (instance.id, instance.instance_type, instance.tags, region)
                details.append({"instance id":  instance.id, "instance type": instance.instance_type, "tags": instance.tags, "region": region})
    return details
