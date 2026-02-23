FROM rocm/dev-ubuntu-20.04:5.7.1

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Remover repositórios antigos e adicionar os corretos
RUN apt-get update && apt-get install -y wget gnupg2 software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Instalar dependências
RUN apt-get update && apt-get install -y \
    wget \
    git \
    python3.9 \
    python3.9-dev \
    python3.9-venv \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Configurar Python 3.9 como padrão
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

# Instalar pip
RUN python -m pip install --upgrade pip wheel setuptools

# Clonar Stable Diffusion WebUI
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /app/stable-diffusion-webui
WORKDIR /app/stable-diffusion-webui

# Usar PyTorch 1.13.1 (compatível com gfx803) - ÚLTIMA VERSÃO QUE FUNCIONA COM RX580
ENV TORCH_COMMAND="pip install torch==1.13.1+rocm5.2 torchvision==0.14.1+rocm5.2 --extra-index-url https://download.pytorch.org/whl/rocm5.2"

# Instalar dependências do WebUI
RUN python -m pip install --upgrade pip && \
    python -c "import torch; print(f'PyTorch version: {torch.__version__}')" || true

# Corrigir repositórios [baseado em experiência anterior]
RUN rm -rf repositories/stable-diffusion-stability-ai && \
    git clone https://github.com/Stability-AI/generative-models.git repositories/stable-diffusion-stability-ai && \
    rm -rf repositories/stable-diffusion-webui-assets && \
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui-assets.git repositories/stable-diffusion-webui-assets

# Script de entrada com todas as variáveis necessárias
RUN echo '#!/bin/bash\n\
export HSA_OVERRIDE_GFX_VERSION=10.3.0\n\
export ROCM_PATH=/opt/rocm\n\
export HIP_VISIBLE_DEVICES=0\n\
export PYTORCH_ROCM_ARCH=gfx803\n\
cd /app/stable-diffusion-webui\n\
python launch.py --skip-torch-cuda-test --medvram --opt-sdp-attention --no-half-vae --listen --precision full --no-half' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
