#!/bin/bash

if [ $# -ne 1 ]; then
  exit 1
fi

GitHubAccountID=$1

curl https://github.com/${GitHubAccountID}.keys >> /home/ec2-user/.ssh/authorized_keys