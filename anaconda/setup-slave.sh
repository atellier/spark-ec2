#!/bin/bash

pushd /root > /dev/null

if [ -d "anaconda" ]; then
  echo "Anaconda seems to be installed. Exiting."
  return
fi

wget https://s3-us-west-2.amazonaws.com/active-spark-ec2-dev/anaconda.tar.gz -O /root/anaconda.tar.gz
echo "Uncompressing Anaconda..."
tar xfz anaconda.tar.gz

echo "Updating Anaconda..."
/root/anaconda/bin/conda update --yes conda  > /dev/null
/root/anaconda/bin/conda update --yes anaconda > /dev/null
/root/anaconda/bin/conda install --yes seaborn > /dev/null

# add export to anaconda if it does not exists
LINE_TO_ADD="export PATH=/root/anaconda/bin:$PATH"
PROFILE="/root/.bash_profile"

grep -qsFx "$LINE_TO_ADD" "$PROFILE" || printf "%s\n" "$LINE_TO_ADD" >> "$PROFILE"

// Re-sourcing the profile
source $PROFILE

popd > /dev/null