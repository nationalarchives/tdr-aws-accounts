import boto3
import time
import sys
from urllib.parse import quote_plus
import os

client = boto3.client("logs", region_name="eu-west-2")
timestamp = int(time.time()) * 1000
log_group_name = f"terraform-plan-outputs-{sys.argv[3]}"
log_stream_name = sys.argv[2]

chunk_size = 180000


def split(list_a):
    for i in range(0, len(list_a), chunk_size):
        yield list_a[i:i + chunk_size]


with open(sys.argv[1]) as file:
    message = file.read()
    if len(message.encode("utf-8")) > chunk_size:
        message_list = message.split("\n")
        split_list = split(message_list)
        log_event = [{'timestamp': timestamp, 'message': "\n".join(x)} for x in split_list]
    else:
        log_event = [{'timestamp': timestamp, 'message': message}]

client.create_log_stream(logGroupName=log_group_name, logStreamName=log_stream_name)
response = client.put_log_events(logGroupName=log_group_name,
                                 logStreamName=log_stream_name,
                                 logEvents=log_event)

base_url = "https://eu-west-2.console.aws.amazon.com/cloudwatch/home"
encoded_stream_name = quote_plus(quote_plus(log_stream_name))
fragment = f"logsV2:log-groups/log-group/{log_group_name}/log-events/{encoded_stream_name}"
url = f"{base_url}?region=eu-west-2#{fragment}"

with open(os.environ['GITHUB_OUTPUT'], 'a') as fh:
    print(f"log-url={url}", file=fh)
