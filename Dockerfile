FROM nvidia/cuda:12.1.1-devel-ubuntu22.04 AS base
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_PREFER_BINARY=1
ENV PYTHONUNBUFFERED=1
ENV CMAKE_BUILD_PARALLEL_LEVEL=8
RUN apt-get update && \
    apt-get install -y \
    git \
    wget \
    curl \
    bash \
    nano \
    libgl1 \
    libglib2.0-0 \
    software-properties-common \
    openssh-server \
    nginx \
    apt-transport-https \
    ca-certificates \
    gnupg \
    python3.10 \
    python3-pip \
    python3.10-venv \
    && ln -sf /usr/bin/python3.10 /usr/bin/python \
    && rm /usr/bin/python3 \
    && ln -sf /usr/bin/python3.10 /usr/bin/python3 \
    && ln -sf /usr/bin/pip3 /usr/bin/pip \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --yes --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get update \
    && apt-get install -y \
    google-cloud-cli
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
RUN pip install \
    comfyui-frontend-package==1.12.14 \
    torchsde==0.2.6 \
    #torchsde==0.2.2 \
    numpy==2.2.4 \
    #numpy>=1.25.0 \
    einops==0.8.1 \
    #einops \
    #transformers>=4.28.1 \
    transformers==4.49.0 \
    tokenizers==0.21.1 \
    #tokenizers>=0.13.3 \
    sentencepiece==0.2.0 \
    # sentencepiece
    #safetensors>=0.4.2 \
    safetensors==0.5.3 \
    aiohttp>=3.11.14 \
    #aiohttp>=3.11.8 \
    yarl==1.18.3 \
    #yarl>=1.18.0 \
    pyyaml \
    #pyyaml \
    #Pillow==11.0.0 \
    Pillow==11.1.0 \
    scipy==1.15.2 \
    tqdm==4.67.1 \
    psutil==7.0.0 \
    #torch==2.2.0 \
    torch==2.6.0 \
    #torchvision==0.17.0 \
    torchvision==0.21.0 \
    torchaudio==2.6.0 \
    #torchaudio==2.2.0 \
#non essential dependencies:
    kornia>=0.7.1 \
    #kornia \
    spandrel==0.4.1 \
    soundfile==0.13.1 \
    av==14.2.0 \
    torchao==0.9.0 \
    git+https://github.com/huggingface/diffusers@363d1ab7e24c5ed6c190abb00df66d9edb74383b \
    lycoris-lora==1.8.3 \
    flatten_json==0.1.14 \
    oyaml==1.0 \
    tensorboard==2.19.0 \
    invisible-watermark==0.2.0 \
    accelerate==1.6.0 \
    toml==0.10.2 \
    albumentations==1.4.15 \
    albucore==0.0.16 \
    pydantic==2.11.1 \
    omegaconf==2.3.0 \
    k-diffusion==0.1.1 \
    open_clip_torch==2.31.0 \
    timm==1.0.15 \
    prodigyopt==1.1.2 \
    controlnet_aux==0.0.7 \
    python-dotenv==1.1.0 \
    bitsandbytes==0.45.4 \
    hf_transfer==0.1.19 \
    lpips==0.1.4 \
    pytorch_fid==0.3.0 \
    optimum-quanto==0.2.4 \
    huggingface_hub==0.30.1 \
    peft==0.15.1 \
    gradio==5.23.3 \
    python-slugify==8.0.4 \
    opencv-python==4.11.0.86 \
    pytorch-wavelets==1.3.0
WORKDIR /
RUN mkdir /common && mkdir /cpu && mkdir /gpu;
COPY common/install.sh common/keep-alive.sh common/rp_handler.py common/logo.txt common/extra_model_paths.yaml /common
COPY cpu/endpoint_start.sh cpu/start.sh /cpu
COPY gpu/endpoint_start.sh gpu/start.sh /gpu
RUN chmod +x /common/install.sh \
    && chmod +x /common/keep-alive.sh \
    && chmod +x /cpu/endpoint_start.sh \
    && chmod +x /cpu/start.sh \
    && chmod +x /gpu/endpoint_start.sh \
    && chmod +x /gpu/start.sh

ENTRYPOINT ["/common/keep-alive.sh"]