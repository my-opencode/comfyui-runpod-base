#!/bin/bash
# Prepares a local volume before mounting.
mkdir -p /workspace/models/unet;
mkdir -p /workspace/models/clip;
mkdir -p /workspace/models/vae;
mkdir -p /workspace/output;
mkdir -p /workspace/rp_output;
cd /workspace;

# for inference
git clone https://github.com/comfyanonymous/ComfyUI.git;
cd ComfyUI;
git reset --hard 3d2e3a6f29670809aa97b41505fa4e93ce11b98d;
cd /workspace;

# if you need to train LoRAs
git clone https://github.com/ostris/ai-toolkit.git;
cd ai-toolkit;
git reset --hard ac1ee559c513d8c2fe46d285a80e3957d3b19a36;
cd /workspace;

# if you only need inference

# if you need to train LoRAs
# Huggingface API key is required
cd /workspace/models/unet;
git lfs install;

cp /common/extra_model_paths.yaml /workspace/ComfyUI/extra_model_paths.yaml;
