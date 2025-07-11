#!/bin/bash

workspace=$(dirname "$(pwd)")

datasets=datasets
timesteps=800
episode_idx=-1

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
gnome-terminal --title="collect" -- bash -c "cd ${workspace}/X7s_PLAY/mobile_aloha/; source ./venv/bin/activate; \
python collect_data.py --datasets $datasets --max_timesteps $timesteps --episode_idx $episode_idx --is_compress; exec bash"
sleep 1