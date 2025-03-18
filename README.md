# ComfyUI Docker with Runpod Wrapper

Provides a docker image ready to work with a ComfyUI install on a runpod network volume in the mounted directory /workspace/ComfyUI.

Based off [https://github.com/blib-la/runpod-worker-comfy/tree/main](https://github.com/blib-la/runpod-worker-comfy/tree/main).

## Requirements

This image requires a specific volume mounted on /workspace:

1. `models` directory

    - holds all models

2. `output` directory

    - for ComfyUI server images

3. `rp_output` directory

    - for ComfyUI server endpoint images

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