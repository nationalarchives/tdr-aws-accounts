#!/usr/bin/env python
#activate virtual environment, e.g.: source /Users/Paul/venv/python3/bin/activate
#for testing: python delete-default-vpcs.py --profile management --dry_run
import boto3
import sys
import time
import json
import argparse
from sessions import get_session

from botocore.exceptions import ClientError
from datetime import datetime

def json_serial(obj):
    """JSON serializer for objects not serializable by default json code"""

    if isinstance(obj, datetime):
        serial = obj.isoformat()
        return serial
    raise TypeError("Type not serializable")

class iam:
    def __init__(self, profile, account_number, stage, deployment_type, dry_run, external_id, role_name):
        self.profile = profile
        self.account_number = account_number
        self.dry_run = dry_run

        if deployment_type == "github":
            self.session = get_session(account_number, role_name, external_id)
        else:
            self.session = boto3.session.Session(profile_name=self.profile)

        self.client = self.session.client('iam')

        aliases = self.client.list_account_aliases()['AccountAliases']
        #print(json.dumps(aliases, sort_keys=True, indent=2, default=json_serial))

        print('Deleting VPCs in Account %s' % aliases[0])

class ec2:
    def __init__(self, profile, account_number, stage, deployment_type, dry_run, external_id, role_name):

        self.profile = profile
        self.account_number = account_number
        self.dry_run = dry_run

        if deployment_type == "github":
            self.session = get_session(account_number, "TDRTerraformRole" + stage.capitalize(), external_id)
        else:
            self.session = boto3.session.Session(profile_name=self.profile)

        self.client = self.session.client('ec2')

        print("Retrieving all AWS regions")
        regions = self.client.describe_regions()['Regions']
        #print('Regions:', regions)

        for region in regions:
            self.client = self.session.client('ec2', region_name=region['RegionName'])
            print("Searching for ec2 resources in region %s" % region['RegionName'])
            igs = self.client.describe_internet_gateways()['InternetGateways']
            vpcs = self.client.describe_vpcs()['Vpcs']
            #print(json.dumps(vpcs, sort_keys=True, indent=2, default=json_serial))

            for vpc in vpcs:
                if vpc['IsDefault']:

                    acls = self.client.describe_network_acls(Filters=[{'Name': 'vpc-id', 'Values': [ vpc['VpcId'] ] } ])['NetworkAcls']
                    for acl in acls:
                        if acl['IsDefault'] != True:
                            print("Deleting network acl %s" % acl['NetworkAclId'])
                            if self.dry_run is None:
                                self.client.delete_network_acl(NetworkAclId=acl['NetworkAclId'])

                    sgs = self.client.describe_security_groups(Filters=[{'Name': 'vpc-id', 'Values': [ vpc['VpcId'] ] } ])['SecurityGroups']
                    for sg in sgs:
                        if sg['GroupName'] != 'default':
                            #print("==========")
                            #print(json.dumps(sg, sort_keys=True, indent=2, default=json_serial))
                            #print("==========")
                            print("Deleting sg %s" % sg['GroupName'])
                            if self.dry_run is None:
                                for i in xrange(0, 20):
                                    try:
                                        self.client.delete_security_group(GroupId=sg['GroupId'])
                                        print("deleted %s" % sg['GroupName'])
                                        break
                                    except ClientError as e:
                                        print("retrying: (error: %s)" % e)
                                        time.sleep(10)
                                    continue

                    for ig in igs:
                        for att in ig['Attachments']:
                            if att['VpcId'] == vpc['VpcId']:
                                print ("Deleting ig %s" % ig['InternetGatewayId'])
                                if self.dry_run is None:
                                    self.client.detach_internet_gateway(InternetGatewayId=ig['InternetGatewayId'], VpcId=vpc['VpcId'])
                                    self.client.delete_internet_gateway(InternetGatewayId=ig['InternetGatewayId'])

                    subnets = self.client.describe_subnets(Filters=[{'Name': 'vpc-id', 'Values': [ vpc['VpcId'] ] } ])['Subnets']
                    for subnet in subnets:
                        print("Deleting subnet %s" % subnet['SubnetId'])
                        #print(json.dumps(subnet, sort_keys=True, indent=2, default=json_serial))
                        if self.dry_run is None:
                            self.client.delete_subnet(SubnetId=subnet['SubnetId'])

            for vpc in vpcs:
                if vpc['IsDefault']:
                    print("Deleting vpc %s" % vpc['VpcId'])
                    if self.dry_run is None:
                        self.client.delete_vpc(VpcId=vpc['VpcId'])
                        print("deleted %s" % vpc['VpcId'])

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Delete Default VPCs")
    parser.add_argument('--profile', default='default')
    parser.add_argument('--account_number')
    parser.add_argument('--stage')
    parser.add_argument('--deployment_type', default='manual')
    parser.add_argument('--external_id')
    parser.add_argument('--project')
    parser.add_argument('--dry_run', action='count')

    args = parser.parse_args()

    profile = args.profile
    account_number = args.account_number
    stage = args.stage
    deployment_type = args.deployment_type
    dry_run = args.dry_run
    external_id = args.external_id
    project = args.project

    role_name = None
    if project == "tdr":
        role_name = "TDRTerraformRole" + stage.capitalize()
    elif project == "dr2":
        role_name = stage.capitalize() + "TerraformRole"

    iam(profile, account_number, stage, deployment_type, dry_run, external_id, role_name)
    ec2(profile, account_number, stage, deployment_type, dry_run, external_id, role_name)
