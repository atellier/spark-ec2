#!/bin/bash

pushd /root/spark-ec2/anaconda > /dev/null
source ./setup-slave.sh

pssh --inline \
    --host "$MASTERS $SLAVES" \
    --user root \
    --extra-args "-t -t $SSH_OPTS" \
    --timeout 0 \
    "/root/spark-ec2/anaconda/setup-slave.sh"

echo "Anaconda installed..."

# Overwrite profile with correct profile
if [ ! -d "/root/.ipython/profile_spark" ]; then
  	/root/anaconda/bin/ipython profile create spark
	wget https://s3-us-west-2.amazonaws.com/active-spark-ec2-dev/profile_spark.tar.gz
	tar xfz profile_spark.tar.gz -C /root/.ipython
fi

popd > /dev/null