#!/bin/bash

pushd /root > /dev/null

if [ -d "anaconda" ]; then
  echo "Anaconda seems to be installed. Exiting."
  return
fi

wget -P /root https://s3-us-west-2.amazonaws.com/active-spark-ec2-dev/Anaconda-2.1.0-Linux-x86_64.sh
bash /root/Anaconda-2.1.0-Linux-x86_64.sh -b -p /root/anaconda

/root/anaconda/bin/conda update --yes conda
/root/anaconda/bin/conda update --yes anaconda
/root/anaconda/bin/conda install --yes seaborn

popd > /dev/null