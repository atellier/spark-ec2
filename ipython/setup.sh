#!/bin/bash

pushd /root/spark-ec2/ipython > /dev/null

# Overwrite profile with correct profile
echo "Installing IPython and related profile..."
if [ ! -d "/root/.ipython/profile_spark" ]; then
	echo "Installing Spark profile on master..."
  	/root/anaconda/bin/ipython profile create spark
  	rm -rf /root/.ipython/profile_spark
	wget https://s3-us-west-2.amazonaws.com/active-spark-ec2-dev/profile_spark.tar.gz -O profile_spark.tar.gz
	tar xfz profile_spark.tar.gz -C /root/.ipython
fi

# resource profile jjst in case (we updated the python path with anaconda)
source /root/.bash_profile

# Then run ipython
mkdir -p /root/ipython/notebook
PYSPARK_DRIVER_PYTHON=ipython PYSPARK_DRIVER_PYTHON_OPTS="notebook --profile=spark" nohup /root/spark/bin/pyspark --master spark://`curl -s http://169.254.169.254/latest/meta-data/public-hostname`:7077 &> /var/log/ipython.log 2>&1&

echo "IPython started..."

popd > /dev/ipython