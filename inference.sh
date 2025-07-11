#!/bin/bash

workspace=$(dirname "$(pwd)")

max_publish_step=10000
ckpt_dir=weights
ckpt_name=policy_best.ckpt

check_path() {
    if [ ! -d "$1" ]; then
        echo "Directory not found: $1"

        exit 1
    fi
}

check_executable() {
    if [ ! -x "$1" ]; then
        echo "Script not executable: $1"
        exit 1
    fi
}

check_path "${workspace}/X7s_PLAY/realsense_camera"
check_path "${workspace}/X7s_PLAY/mobile_aloha"

check_executable "${workspace}/X7s_PLAY/realsense_camera/realsense.sh"

gnome-terminal --title="realsense" -- bash -c "cd ${workspace}/X7s_PLAY/realsense_camera; bash realsense.sh; exec bash"
sleep 1
gnome-terminal --title="inference" -- bash -c "cd ${workspace}/X7s_PLAY/mobile_aloha; source ./venv/bin/activate; \
python inference.py --max_publish_step $max_publish_step --ckpt_dir $ckpt_dir --ckpt_name $ckpt_name; exec bash"
sleep 1