#!/bin/bash
# Prepares a local volume before mounting.
mkdir -p ./volume/models;
mkdir -p ./volume/output;
mkdir -p ./volume/rp_output;
cd ./volume;
git clone https://github.com/comfyanonymous/ComfyUI.git;
cd ComfyUI;
git reset --hard 3d2e3a6f29670809aa97b41505fa4e93ce11b98d;
cd ../..;
cp ./common/extra_model_paths.yaml ./volume/ComfyUI/extra_model_paths.yaml;