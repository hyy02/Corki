#!/bin/bash

# export PATH=/opt/conda/envs/corki/bin:$PATH
# export LD_LIBRARY_PATH=/opt/conda/envs/corki/lib:$LD_LIBRARY_PATH

# 更稳定的 conda 初始化方式
source /opt/conda/etc/profile.d/conda.sh
conda activate corki

# export http_proxy=http://10.70.10.73:8412   
# export https_proxy=http://10.70.10.73:8412  

#Install dependency for calvin
# sudo apt-get -y install libegl1-mesa libegl1
# sudo apt-get -y install libgl1

# sudo apt-get update -y -qq
# sudo apt-get install -y -qq libegl1-mesa libegl1-mesa-dev

# sudo apt install -y mesa-utils libosmesa6-dev llvm
# sudo apt-get -y install meson
# sudo apt-get -y build-dep mesa

# sudo apt-get -y install freeglut3
# sudo apt-get -y install freeglut3-dev

# sudo apt update -y
# sudo apt install -y xvfb


# sudo apt-get install -y --reinstall libgl1-mesa-dri

# Xvfb :99 -screen 0 1024x768x16 &

# export DISPLAY=:99
# export PYTHONPATH=/RoboFlamingo-origin
# export LIBGL_ALWAYS_SOFTWARE=1
# export EVALUTION_ROOT=$(pwd)

# python try.py
python eval_ckpts.py
