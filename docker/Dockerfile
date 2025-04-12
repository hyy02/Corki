## For Most of users
# FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04
## For Chinese users
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

# --- 安装系统依赖和 OpenGL 渲染相关 ---

RUN sed -i 's/^# deb-src/deb-src/' /etc/apt/sources.list && \
    apt-get update -y -qq && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        tzdata \
        git wget curl vim unzip ffmpeg \
        build-essential cmake pkg-config \
        llvm meson \
        libegl1-mesa \
        libegl1-mesa-dev \
        libegl1 \
        libgl1 \
        mesa-utils \
        libsm6 libxext6 libxrender-dev \
        libosmesa6-dev && \
    apt-get build-dep -y mesa && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda to /opt/conda
RUN curl -o ~/miniconda.sh -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
chmod +x ~/miniconda.sh && \
~/miniconda.sh -b -p /opt/conda && \
rm ~/miniconda.sh

# Set environment variables
ENV PATH=/opt/conda/bin:$PATH

# Avoid git problems
COPY . /home/

# 创建 conda 环境和安装必要的依赖

# RUN conda create -n corki python=3.8 -y && \
#      echo "source activate corki" >> ~/.bashrc
#      /bin/bash -c "source ~/.bashrc && conda activate corki && pip uninstall setuptools -y && pip install setuptools==57.5.0 && cd /home/calvin && sh install.sh"
# # conda run -n corki pip install wheel cmake==3.18.4 && \
# # conda run -n corki pip install -e /home/calvin/calvin_env/tacto && \
# # conda run -n corki pip install -e /home/calvin

# RUN conda create -n corki python=3.8 -y && \
#     /bin/bash -c "eval \"$(conda shell.bash hook)\" && \
#     conda activate corki && \
#     pip uninstall setuptools -y && \
#     pip install setuptools==57.5.0 && \
#     cd /home/calvin && \
#     sh install.sh"

# RUN conda run -n corki pip install -r /home/Corki/requirements.txt \
#       -f https://download.pytorch.org/whl/torch_stable.html \
#       -i https://pypi.tuna.tsinghua.edu.cn/simple

# RUN conda create -n corki python=3.8 -y && \
#     /bin/bash -c "eval \"$(conda shell.bash hook)\" && \
#     conda activate corki && \
#     pip uninstall setuptools -y && \
#     pip install setuptools==57.5.0 && \
#     cd /home/calvin && \
#     sh install.sh && \
#     pip install -r /home/Corki/requirements.txt \
#         -f https://download.pytorch.org/whl/torch_stable.html \
#         -i https://pypi.tuna.tsinghua.edu.cn/simple"

# RUN conda create -n corki python=3.8 -y && \
#     conda run -n corki pip uninstall setuptools -y && \
#     conda run -n corki pip install setuptools==57.5.0 && \
#     conda run -n corki bash -c "cd /home/calvin && sh install.sh" && \
#     conda run -n corki pip install -r /home/Corki/requirements.txt \
#         -f https://download.pytorch.org/whl/torch_stable.html \
#         -i https://pypi.tuna.tsinghua.edu.cn/simple

RUN conda create -n corki python=3.8 -y && \
    /bin/bash -c "source /opt/conda/bin/activate corki && \
    pip uninstall setuptools -y && \
    pip install setuptools==57.5.0 && \
    cd /home/calvin && \
    sh install.sh && \
    pip install -r /home/Corki/requirements.txt \
        -f https://download.pytorch.org/whl/torch_stable.html \
        -i https://pypi.tuna.tsinghua.edu.cn/simple"


