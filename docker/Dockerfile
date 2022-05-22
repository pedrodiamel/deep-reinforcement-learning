FROM nvidia/cuda:10.2-cudnn8-devel-ubuntu16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-keyring_1.0-1_all.deb
RUN dpkg -i cuda-keyring_1.0-1_all.deb
RUN rm /etc/apt/sources.list.d/cuda.list
RUN sed -i '/developer\.download\.nvidia\.com\/compute\/cuda\/repos/d' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    curl \
    tmux \
    byobu \
    vim \
    git \
    gdebi-core \
    build-essential \
    python3-pip \
    unzip \
    htop \
    mesa-utils \
    xorg-dev \
    xorg \
    libssl-dev \
    libffi-dev \
    python-dev \
    python3-dev \
    pkg-config \
    libxau-dev \
    libxdmcp-dev \
    libxcb1-dev \
    libxext-dev \
    libx11-dev \
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libgles2-mesa-dev \
    xvfb

# replace with other Ubuntu version if desired
# see: https://hub.docker.com/r/nvidia/opengl/
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
    /usr/local/lib/x86_64-linux-gnu \
    /usr/local/lib/x86_64-linux-gnu

# replace with other Ubuntu version if desired
# see: https://hub.docker.com/r/nvidia/opengl/
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
    /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json \
    /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json

RUN echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    ldconfig && \
    echo '/usr/local/$LIB/libGL.so.1' >> /etc/ld.so.preload && \
    echo '/usr/local/$LIB/libEGL.so.1' >> /etc/ld.so.preload


# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


RUN wget https://bootstrap.pypa.io/pip/3.5/get-pip.py
RUN python3 get-pip.py

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    tee /usr/share/keyrings/cloud.google.gpg && \
    apt-get update -y && apt-get install google-cloud-sdk -y

RUN python3 -m pip install --upgrade pip
RUN pip install setuptools==41.0.0

ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH


# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

WORKDIR /workspaces/drl
# RUN pip -q install ./python