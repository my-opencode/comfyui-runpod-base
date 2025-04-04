# ComfyUI Docker with Runpod Wrapper

Provides a single docker image able to run ComfyUI and AI-toolkit.
This image can run:
- a ComfyUI server,
- a serverless Runpod endpoint running a ComfyUI server, and,
- an AI-toolkit LoRA trainer
All from a pre-installed runpod network volume.


Based off [https://github.com/blib-la/runpod-worker-comfy/tree/main](https://github.com/blib-la/runpod-worker-comfy/tree/main).

## Requirements

This image requires a specific volume mounted on /workspace:

1. `models` directory

    - holds all models
    - For flux, I recommend:
        - Clone FLUX.1-dev into /workspace/unet/FLUX.1-dev
        - Delete /workspace/unet/FLUX.1-dev/.git (50gb)
        - Create a symbolic link from /workspace/unet/FLUX.1-dev/flux1-dev.safetensors to /workspace/unet/flux1-dev.safetensors

2. `output` directory

    - for images generated by the ComfyUI server

3. `rp_output` directory

    - for images generated by the serverless endpoint ComfyUI server

4. `ComfyUI` directory

    - clone of [https://github.com/comfyanonymous/ComfyUI.git](https://github.com/comfyanonymous/ComfyUI.git)
    - includes a copy of `common/extra_model_paths.yaml` 

Use the `prepare_volume.sh` script to prepare the volume before mounting.

## Usage

The `docker-compose.yaml` file highlights how to build and start this image.

| Action                                      | Command                                    |
|---------------------------------------------|--------------------------------------------|
| Install                                     | `docker compose --profile install up`      |
| Start a CPU ComfyUI server                  | `docker compose --profile start-cpu up`    |
| Start a CPU ComfyUI server endpoint wrapper | `docker compose --profile endpoint-cpu up` |
| Start a ComfyUI server                      | `docker compose --profile start up`        |
| Start a ComfyUI server endpoint wrapper     | `docker compose --profile endpoint up`     |