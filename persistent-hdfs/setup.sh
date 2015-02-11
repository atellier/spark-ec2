#!/bin/bash

PERSISTENT_HDFS=/root/persistent-hdfs

pushd /root/spark-ec2/persistent-hdfs > /dev/null
source ./setup-slave.sh

for node in $SLAVES $OTHER_MASTERS; do
  ssh -t $SSH_OPTS root@$node "/root/spark-ec2/persistent-hdfs/setup-slave.sh" & sleep 0.3
done
wait

/root/spark-ec2/copy-dir $PERSISTENT_HDFS/conf

if [[ ! -e /vol/persistent-hdfs/dfs/name ]] ; then
  echo "Formatting persistent HDFS namenode..."
  $PERSISTENT_HDFS/bin/hadoop namenode -format
fi

echo "Starting persistent HDFS..."
# This is different depending on version. Simple hack: just try both.
$PERSISTENT_HDFS/sbin/start-dfs.sh
$PERSISTENT_HDFS/bin/start-dfs.sh

popd > /dev/null
