#!/bin/bash

# Setup Anaconda
cd ~
wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
bash Anaconda3-2019.03-Linux-x86_64.sh
source .bashrc

# configure jupyter
jupyter notebook --generate-config
jupyter notebook password
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout .mykey.key -out .mycert.pem

echo "
# Zarul appended
c.NotebookApp.certfile = '/home/ubuntu/.mycert.pem'
c.NotebookApp.keyfile = '/home/ubuntu/.mykey.key'
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.allow_remote_access = True
c.NotebookApp.port = 9999
" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py

# install Jupyter lab
conda install jupyterlab -y

# bash kernel
pip install bash_kernel
python -m bash_kernel.install