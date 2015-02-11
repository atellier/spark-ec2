#!/bin/bash

pushd /root/spark-ec2/anaconda > /dev/null
source ./setup-slave.sh

for node in $SLAVES $OTHER_MASTERS; do
  ssh -t $SSH_OPTS root@$node "/root/spark-ec2/anaconda/setup-slave.sh" & sleep 0.3
done
wait

echo "Anaconda installed..."

popd > /dev/null