#!/bin/bash

pushd /root > /dev/null

if [ -d "miniconda" ]; then
  echo "Miniconda seems to be installed. Exiting."
  return
fi

wget -P /root http://repo.continuum.io/miniconda/Miniconda-3.8.3-Linux-x86_64.sh
bash /root/Miniconda-3.8.3-Linux-x86_64.sh -b -p /root/miniconda

/root/miniconda/bin/conda update --yes conda
/root/miniconda/bin/conda install --yes matplotlib
/root/miniconda/bin/conda install --yes seaborn

popd > /dev/null

# add export to miniconda if it does not exists
LINE_TO_ADD="export PATH=/root/miniconda/bin:$PATH"
PROFILE="/root/.bash_profile"

grep -qsFx "$LINE_TO_ADD" "$PROFILE" || printf "%s\n" "$LINE_TO_ADD" >> "$PROFILE"