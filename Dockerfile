FROM rocm/dev-ubuntu-20.04:5.7.1

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y wget gnupg2 software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    wget \
    git \
    python3.9 \
    python3.9-dev \
    python3.9-venv \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1
RUN python -m pip install --upgrade pip wheel setuptools

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /app/stable-diffusion-webui
WORKDIR /app/stable-diffusion-webui

ENV TORCH_COMMAND="pip install torch==1.13.1+rocm5.2 torchvision==0.14.1+rocm5.2 --extra-index-url https://download.pytorch.org/whl/rocm5.2"

RUN python -m pip install --upgrade pip && \
    python -c "import torch; print(f'PyTorch version: {torch.__version__}')" || true

RUN rm -rf repositories/stable-diffusion-stability-ai && \
    git clone https://github.com/Stability-AI/generative-models.git repositories/stable-diffusion-stability-ai && \
    rm -rf repositories/stable-diffusion-webui-assets && \
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui-assets.git repositories/stable-diffusion-webui-assets

RUN echo '#!/bin/bash\n\
export HSA_OVERRIDE_GFX_VERSION=10.3.0\n\
export ROCM_PATH=/opt/rocm\n\
export HIP_VISIBLE_DEVICES=0\n\
export PYTORCH_ROCM_ARCH=gfx803\n\
cd /app/stable-diffusion-webui\n\
python launch.py --skip-torch-cuda-test --medvram --opt-sdp-attention --no-half-vae --listen --precision full --no-half' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Link com o repositório GitHub
LABEL org.opencontainers.image.source https://github.com/danarcanjosilva/ROCm-StableDiffusion-RX580

ENTRYPOINT ["/entrypoint.sh"]
