#!/bin/bash

# Setup Anaconda
cd ~
wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
bash Anaconda3-2019.03-Linux-x86_64.sh -b -p "$HOME""/.anaconda3"
# echo ". /home/ubuntu/.anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc
eval "$($PREFIX/bin/conda shell.YOUR_SHELL_NAME hook)"
/home/ubuntu/.anaconda3/bin/conda init
echo "conda activate" >> ~/.bashrc
sleep 2
source .bashrc

# configure jupyter
jupyter notebook --generate-config
passwd=$(echo -e "from notebook.auth import passwd; print(passwd('m123'))" | python)
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout .mykey.key -out .mycert.pem \
 -subj "/C=MY/ST=Selangor/L=ShahAlam/O=MonashUni/OU=GenomicsFacility/CN=Zarul/emailaddress=zarulsaurus@gmail.com"

echo "
# Zarul appended
c.NotebookApp.certfile = '/home/ubuntu/.mycert.pem'
c.NotebookApp.keyfile = '/home/ubuntu/.mykey.key'
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.allow_remote_access = True
c.NotebookApp.port = 9999
" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py

echo "c.NotebookApp.password = ""$passwd" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py

# install Jupyter lab
conda install jupyterlab -y

# bash kernel
pip install bash_kernel
python -m bash_kernel.install