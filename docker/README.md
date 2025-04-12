## 🚀 Corki Docker Environment

This project provides a Docker development environment for the **Corki** project, including a preconfigured Python 3.8 Conda environment and all necessary dependencies. Everything is automated and we highly recommend using docker

------

### 📦 Features

- ✅ Python 3.8 with Conda environment (`corki`)
- ✅ Pre-installed dependencies from `requirements.txt`
- ✅  Egl dependencies 
- ✅ Compatible with PyTorch 
- ✅ Custom `install.sh` script support



## Basic preparation

```bash
# Clone the repo at the current docker path e.g your_dir/Corki/docker
git clone --recurse-submodules https://github.com/hyy02/calvin.git
git clone https://github.com/hyy02/Corki.git

# Need to Specific the dir to download the model and dataset, make sure have enough space (30G)
export CORKI_MODEL_DIR=/your_dir_to_download
export CORKI_DATA_DIR=/your_dir_to_download

# Download the huggingface model
pip install -U huggingface_hub
# For Chinese users: export HF_ENDPOINT=https://hf-mirror.com to speed up installation
huggingface-cli download anas-awadalla/mpt-1b-redpajama-200b-dolly --local-dir "${CORKI_MODEL_DIR}/anas-awadalla/mpt-1b-redpajama-200b-dolly"
huggingface-cli download openflamingo/OpenFlamingo-3B-vitl-mpt1b-langinstruct --local-dir "${CORKI_MODEL_DIR}/openflamingo/OpenFlamingo-3B-vitl-mpt1b-langinstruct/"

# Download the calvin debug dataset (only 1.2G)
wget -P ${CORKI_DATA_DIR} http://calvin.cs.uni-freiburg.de/dataset/calvin_debug_dataset.zip
unzip "${CORKI_DATA_DIR}/calvin_debug_dataset.zip"

```

### 🐳 Build the Docker Image and run the container

Make sure you’re in the root directory of this project (where the `Dockerfile` and `requirements.txt` are located), then run:

```bash
# Build the image, Mount the model and data path
bash build_and_run.sh
```

------

### 📁 File Structure (Docker Container)

```
/
├── /home/Corki # Corki project dir
├── /home/calvin # calvin project dir 
├── /data # calvin debug dataset dir 
└── /modelzoo # checkpoint dir
└── /opt/conda/envs/corki/bin # conda environment dir
```

------

### ⚙️ Inside the Container

Once inside the container:

```bash
bash /home/Corki/docker/prepare.bash
```

> Note:  The bash used to fix two problems:
>
> 1. Egl error, see:https://github.com/NVIDIA/nvidia-docker/issues/1520
> 2. Tactile sensor is not used: so we change the file in the data hydra yaml.

------

## The Minimal try to run the code base

```bash
bash tools/train.sh robot_flamingo/configs/robot_flamingo_episode_sum_debug.args
```

- The config above will use 8 GPU （you can change in tools/train.sh torch --nnodes to specific your server）with VRAM above 31 GB, and only train one epoch use calvin_debug_dataset, it only takes several seconds

```bash
bash eval_ckpts.bash
```

- This will automatically start running the test script. Please note that the debug data does not reflect the actual performance. If you see the output below, it indicates that your environment is configured correctly.

  ```bash
  Loading robot-flamingo checkpoint from /modelzoo/checkpoint_gripper_post_hist_1_aug_10_4_traj_cons_ws_12_mpt_dolly_3b_9_fur_step_0.pth0.pth
  argv[0]=--width=200
  argv[1]=--height=200
  EGL device choice: -1 of 8.
  Loaded EGL 1.5 after reload.
  GL_VENDOR=NVIDIA Corporation
  GL_RENDERER=NVIDIA A100-SXM4-40GB/PCIe/SSE2
  GL_VERSION=3.3.0 NVIDIA 550.90.07
  GL_SHADING_LANGUAGE_VERSION=3.30 NVIDIA via Cg compiler
  Version = 3.3.0 NVIDIA 550.90.07
  Vendor = NVIDIA Corporation
  Renderer = NVIDIA A100-SXM4-40GB/PCIe/SSE2
  logging to /modelzoo/checkpoint_gripper_post_hist_1_aug_10_4_traj_cons_ws_12_mpt_dolly_3b_9_fur_step_0_action_num_5_h
    0%|          | 0/1000 [00:00<?, ?it/s]ven = NVIDIA Corporation
  ven = NVIDIA Corporation
  0/1|1/5 : 0.0% | 2/5 : 0.0% | 3/5 : 0.0% | 4/5 : 0.0% | 5/5 : 0.0% ||:   0%|          | 1/1000 [00:14<4:04:27, 14.68s/it]
  ```

### 🧪 Tips & Troubleshooting

- 🐌 Slow install? Use `-i https://pypi.tuna.tsinghua.edu.cn/simple` to speed up PyPI downloads in China.
- ⚠️ Avoid using `source ~/.bashrc` in Docker `RUN` commands — prefer `eval "$(conda shell.bash hook)"`.

------

### 📝 License

  MIT
