#!/bin/bash

docker cp runner:/usr/bin/aws /tmp/aws

#change name, and zip
tar -czf aws_2.1.29_linux_amd64.tar.gz aws

md5sum aws_2.1.29_linux_amd64.tar.gz > aws_2.1.29_checksums.txt

