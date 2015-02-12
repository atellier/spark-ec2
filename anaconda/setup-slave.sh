#!/bin/bash

pushd /root > /dev/null

if [ -d "anaconda" ]; then
  echo "Anaconda seems to be installed. Exiting."
  return
fi

wget -P /root https://s3-us-west-2.amazonaws.com/active-spark-ec2-dev/anaconda.tar.gz
tar xfz anaconda.tar.gz

/root/anaconda/bin/conda update --yes conda
/root/anaconda/bin/conda update --yes anaconda
/root/anaconda/bin/conda install --yes seaborn

# add export to miniconda if it does not exists
LINE_TO_ADD="export PATH=/root/anaconda/bin:$PATH"
PROFILE="/root/.bash_profile"

grep -qsFx "$LINE_TO_ADD" "$PROFILE" || printf "%s\n" "$LINE_TO_ADD" >> "$PROFILE"

. "$PROFILE"

popd > /dev/null