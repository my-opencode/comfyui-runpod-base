FROM nvidia/cuda:12.1.1-devel-ubuntu22.04 as base
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_PREFER_BINARY=1
ENV PYTHONUNBUFFERED=1
ENV CMAKE_BUILD_PARALLEL_LEVEL=8
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    git \
    wget \
    curl \
    bash \
    nano \
    libgl1 \
    libgl2.0-0 \
    software-properties-common \
    openssh-server \
    nginx \
    python3.10 \
    python3-pip \
    python3.10-venv \
    && ln -sf /usr/bin/python3.10 /usr/bin/python \
    && rm /usr/bin/python3 \
    && ln -sf /usr/bin/python3.10 /usr/bin/python3 \
    && ln -sf /usr/bin/pip3 /usr/bin/pip
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
RUN pip install torch==2.2.0 torchvision==0.17.0 torchaudio==2.2.0 
WORKDIR /
RUN mkdir /common && mkdir /cpu && mkdir /gpu;
COPY common/install.sh common/keep-alive.sh common/rp_handler.py common/logo.txt /common
COPY cpu/endpoint_start.sh cpu/start.sh /cpu
COPY gpu/endpoint_start.sh gpu/start.sh /gpu
RUN chmod +x /common/install.sh \
    && chmod +x /common/keep-alive.sh \
    && chmod +x /cpu/endpoint_start.sh \
    && chmod +x /cpu/start.sh \
    && chmod +x /gpu/endpoint_start.sh \
    && chmod +x /gpu/start.sh
