#!/bin/bash

# Download the model
MODEL=./checkpoint/cp_best.pt.tar
if [ -f "$MODEL" ]; then
    echo "$MODEL exist, skipping download."
else
    wget https://srm-model-zoo.s3-us-west-1.amazonaws.com/cp_best.pt.tar -O checkpoint/cp_best.pt.tar
fi

# Download the installer, install and then remove the installer
wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
/bin/bash ~/miniconda.sh -b -p /opt/conda
rm ~/miniconda.sh
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

# Set conda path
echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

PS1='$ '
source ~/.bashrc

# Update conda
conda update -y conda 

# Create an environment
conda env create -f environment.yml
echo "conda activate planet-amazon" >> ~/.bashrc
source ~/.bashrc

# Run the model
# python predict.py