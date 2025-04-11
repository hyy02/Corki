#!/bin/bash
# eval "$('/mnt/dolphinfs/hdd_pool/docker/user/hadoop-vacv/yanfeng/software/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# conda activate /mnt/dolphinfs/hdd_pool/docker/user/hadoop-vacv/yanfeng/software/anaconda3/envs/RoboFlamingo_ubuntu/ 
# source /opt/conda/etc/profile.d/conda.sh
# conda activate corki

# # Install dependency for calvin
# apt-get -y install libegl1-mesa libegl1
# apt-get -y install libgl1

# apt-get update -y -qq
# apt-get install -y -qq libegl1-mesa libegl1-mesa-dev

# apt install -y mesa-utils libosmesa6-dev llvm
# apt-get -y install meson
# apt-get -y build-dep mesa

# apt-get -y install freeglut3
# apt-get -y install freeglut3-dev

# apt update -y 
# apt install -y xvfb


# apt-get install -y --reinstall libgl1-mesa-dri


# Xvfb :99 -screen 0 1024x768x16 &

# export DISPLAY=:99
export PYTHONPATH=/home/Corki
export EVALUTION_ROOT=$(pwd)

# !!! Set for your own path
calvin_dataset_path='/data/calvin_debug_dataset/'
# calvin_conf_path
calvin_conf_path="/home/calvin/calvin_models/conf"
# language model path
lm_path='/modelzoo/anas-awadalla/mpt-1b-redpajama-200b-dolly'
# tokenizer path
tokenizer_path='/modelzoo/anas-awadalla/mpt-1b-redpajama-200b-dolly'

evaluate_from_checkpoint=$1
log_file=$2
use_gripper=$3
use_state=$4
fusion_mode=$5
window_size=$6
export MESA_GL_VERSION_OVERRIDE=4.1
echo logging to ${log_file}
node_num=1

if [ ${use_gripper} -eq 1 ] && [ ${use_state} -eq 1 ]
then
torchrun --nnodes=1 --nproc_per_node=${node_num}  --master_port=6066 robot_flamingo/eval/eval_calvin.py \
    --precision fp32 \
    --use_gripper \
    --use_state \
    --window_size ${window_size} \
    --fusion_mode ${fusion_mode} \
    --run_name RobotFlamingoDBG \
    --calvin_dataset ${calvin_dataset_path} \
    --lm_path ${lm_path} \
    --tokenizer_path ${tokenizer_path} \
    --cross_attn_every_n_layers 4 \
    --evaluate_from_checkpoint ${evaluate_from_checkpoint} \
    --calvin_conf_path ${calvin_conf_path} \
    --workers 1  |& tee -a ${log_file}
fi

if [ ${use_gripper} -eq 1 ] && [ ${use_state} -eq 0 ]
then
torchrun --nnodes=1 --nproc_per_node=${node_num}  --master_port=29502 robot_flamingo/eval/eval_calvin.py \
    --precision fp32 \
    --use_gripper \
    --window_size ${window_size} \
    --fusion_mode ${fusion_mode} \
    --run_name RobotFlamingoDBG \
    --calvin_dataset ${calvin_dataset_path} \
    --lm_path ${lm_path} \
    --tokenizer_path ${tokenizer_path} \
    --cross_attn_every_n_layers 4 \
    --evaluate_from_checkpoint ${evaluate_from_checkpoint} \
    --calvin_conf_path ${calvin_conf_path} \
    --use_episode \
    --waypoint \
    --use_waypoint \
    --threshold 0.5 \
    --mask_ratio 0.5 \
    --adaptive feng \
    --episode_loss point_sum \
    --workers 1 |& tee -a ${log_file}
fi

if [ ${use_gripper} -eq 0 ] && [ ${use_state} -eq 0 ]
then
torchrun --nnodes=1 --nproc_per_node=${node_num}  --master_port=6066 robot_flamingo/eval/eval_calvin.py \
    --precision fp32 \
    --run_name RobotFlamingoDBG \
    --window_size ${window_size} \
    --fusion_mode ${fusion_mode} \
    --calvin_dataset ${calvin_dataset_path} \
    --lm_path ${lm_path} \
    --tokenizer_path ${tokenizer_path} \
    --cross_attn_every_n_layers 4 \
    --evaluate_from_checkpoint ${evaluate_from_checkpoint} \
    --calvin_conf_path ${calvin_conf_path} \
    --workers 1 |& tee -a ${log_file}
fi
