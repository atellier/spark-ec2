#!/bin/bash

pushd /root/spark-ec2/anaconda > /dev/null
source ./setup-slave.sh

echo "Anaconda installed on master..."

pssh --inline \
    --host "$MASTERS $SLAVES" \
    --user root \
    --extra-args "-t -t $SSH_OPTS" \
    --timeout 0 \
    "source /root/spark-ec2/anaconda/setup-slave.sh"

echo "Anaconda installed on slaves..."

popd > /dev/null