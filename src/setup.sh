#!/usr/bin/env bash

user=XXX
jupy_port=XXY


sudo apt install openconnect git vim neovim xclip tree
sudo adduser $user

su $user
cd ~

miniconda_link=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
wget $miniconda_link
bash $(basename $miniconda_link) -b -p $HOME/miniconda3 -f

##########

eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
conda init
conda config --set auto_activate_base true

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout .mykey.key -out .mycert.pem

##########

conda install -c conda-forge mamba -y

mamba install -c conda-forge jupyter jupyter_server jupyterlab -y
jupyter server --generate-config
jupyter server password

##########

jupyter notebook --generate-config
jupyter notebook password

##########

echo """
c.NotebookApp.certfile = '$HOME/.mycert.pem'
c.NotebookApp.keyfile = '$HOME/.mykey.key'
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.allow_remote_access = True
c.NotebookApp.port = $jupy_port
""" >> $HOME/.jupyter/jupyter_server_config.py

echo """
c.NotebookApp.certfile = '$HOME/.mycert.pem'
c.NotebookApp.keyfile = '$HOME/.mykey.key'
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.allow_remote_access = True
c.NotebookApp.port = $jupy_port
""" >> $HOME/.jupyter/jupyter_notebook_config.py