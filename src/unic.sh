#!/bin/bash

conda env create -f unic.yaml
conda activate unic

pip install bash_kernel
python -m bash_kernel.install