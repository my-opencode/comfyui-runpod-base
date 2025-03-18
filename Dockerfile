FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04 as base
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_PREFER_BINARY=1
ENV PYTHONUNBUFFERED=1
ENV CMAKE_BUILD_PARALLEL_LEVEL=8
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3.10-venv \
    git \
    wget \
    libgl1 \
    && ln -sf /usr/bin/python3.10 /usr/bin/python \
    && ln -sf /usr/bin/pip3 /usr/bin/pip
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
RUN pip install runpod requests
WORKDIR /
RUN mkdir /common && mkdir /cpu && mkdir /gpu;
COPY common/install.sh common/rp_handler.py /common
COPY cpu/endpoint_start.sh cpu/start.sh /cpu
COPY gpu/endpoint_start.sh gpu/start.sh /gpu
