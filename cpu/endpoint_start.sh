#!/bin/bash

# Use libtcmalloc for better memory management
TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
export LD_PRELOAD="${TCMALLOC}"

cd /workspace/ComfyUI;
source venv/bin/activate;

# Serve the API and don't shutdown the container
if [ "$SERVE_API_LOCALLY" == "true" ]; then
    echo "runpod-worker-comfy: Starting ComfyUI"
    python main.py --cpu --disable-auto-launch --output-directory /workspace/rp_output --listen &

    echo "runpod-worker-comfy: Starting RunPod Handler"
    python -u /common/rp_handler.py --rp_serve_api --rp_api_host=0.0.0.0
else
    echo "runpod-worker-comfy: Starting ComfyUI"
    python main.py --cpu --disable-auto-launch --output-directory /workspace/rp_output &

    echo "runpod-worker-comfy: Starting RunPod Handler"
    python -u /common/rp_handler.py
fi
