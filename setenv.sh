#!/bin/bash

export AWS_CONFIG_FILE=secrets/aws_config
export AWS_KEY_NAME=vpc-test.pem
export AWS_KEY_PATH=secrets/$AWS_KEY_NAME

if [[ ! -z $1 ]]; then
    stack_name=$1
    ec2_id=$(aws cloudformation describe-stack-resources --stack-name $stack_name | \
	     jq -r '.StackResources[] | select(.ResourceType == "AWS::EC2::Instance") | .PhysicalResourceId')
    export AWS_EC2_IP=$(aws ec2 describe-instances --instance-ids $ec2_id | \
			    jq -r '.Reservations[] | .Instances[] | .PublicIpAddress')
fi

