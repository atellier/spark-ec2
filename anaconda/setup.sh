#!/bin/bash

pushd /root/spark-ec2/anaconda > /dev/null

echo "Installing Anaconda on masters and slaves..."
pssh --inline \
    --host "$MASTERS $SLAVES" \
    --user root \
    --extra-args "-t -t $SSH_OPTS" \
    --timeout 0 \
    "source /root/spark-ec2/anaconda/setup-slave.sh"

echo "Anaconda installed on masters and slaves..."

popd > /dev/null