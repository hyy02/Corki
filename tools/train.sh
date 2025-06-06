#!/usr/bin/env bash

set -x
set -o pipefail

# ==== 环境修复部分 ====
export PATH=/opt/conda/envs/corki/bin:$PATH
export LD_LIBRARY_PATH=/opt/conda/envs/corki/lib:$LD_LIBRARY_PATH

# 更稳定的 conda 初始化方式
source /opt/conda/etc/profile.d/conda.sh
conda activate corki

# ==== 输出路径处理 ====
args=$(cat $1)
nodes=$2
OUTPUT_BASE=$(echo $1 | sed -e "s/robot_flamingo\/configs/exps/g" | sed -e "s/.args$//g")
OUTPUT_BASE=/home/Corki/$OUTPUT_BASE
mkdir -p $OUTPUT_BASE

mkdir -p "$OUTPUT_BASE"

which torchrun
# ==== 启动训练 ====
torchrun --nnodes=1 --nproc_per_node=$nodes --master_port=29502 \
  robot_flamingo/train/train_calvin.py \
  ${args} --run_name "$OUTPUT_BASE" \
  |& tee -a "$OUTPUT_BASE/output.log"
