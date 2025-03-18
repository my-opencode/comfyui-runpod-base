#!/bin/bash
mkdir -p ./volume/models;
mkdir -p ./volume/output;
mkdir -p ./volume/rp_output;
cd ./volume;
git clone https://github.com/comfyanonymous/ComfyUI.git;
cd ..;
cp ./common/extra_model_paths.yaml ./volume/ComfyUI/extra_model_paths.yaml;