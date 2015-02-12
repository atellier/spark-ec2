#!/bin/bash

pushd /root/spark-ec2/anaconda > /dev/null
source ./setup-slave.sh

for node in $SLAVES $OTHER_MASTERS; do
  ssh -t $SSH_OPTS root@$node "/root/spark-ec2/anaconda/setup-slave.sh" & sleep 0.3
done
wait

echo "Anaconda installed..."

# Overwrite profile with correct profile
if [ ! -d "/root/.ipython/profile_spark" ]; then
  	/root/anaconda/bin/ipython profile create spark
	wget https://s3-us-west-2.amazonaws.com/active-spark-ec2-dev/profile_spark.tar.gz
	tar xfz profile_spark.tar.gz -C /root/.ipython
fi

# Then run ipython
PYSPARK_DRIVER_PYTHON=ipython PYSPARK_DRIVER_PYTHON_OPTS="notebook --profile=spark" /root/spark/bin/pyspark --master spark://`curl -s http://169.254.169.254/latest/meta-data/public-hostname`:7077&

echo "IPython started..."

popd > /dev/null