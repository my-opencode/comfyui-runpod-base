#!/bin/bash
cd /workspace/ComfyUI;
python -m venv venv;
source venv/bin/activate;
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118 --no-cache-dir;
pip install -r requirements.txt --no-cache-dir;
echo "ComfyUI is installed and ready to be started";
