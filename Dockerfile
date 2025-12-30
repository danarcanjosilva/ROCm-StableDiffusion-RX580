FROM woodrex/rocm612-torch24-gfx803

ENV HSA_OVERRIDE_GFX_VERSION=8.0.3
ENV PYTORCH_ROCM_ARCH=gfx803
ENV PYTHONUNBUFFERED=1

WORKDIR /stable-diffusion-webui

#RUN git clone https://github.com/woodrex83/stable-diffusion-webui-rx580.git .

COPY stable-diffusion-webui /stable-diffusion-webui

RUN pip install -r requirements_versions.txt

# COMENTE ESTA LINHA (a ruim)
# ENTRYPOINT ["python", "launch.py",  "--listen", "--medvram"]

# DESCOMENTE ESTA LINHA (a boa para RX 580)
ENTRYPOINT ["python", "launch.py", "--listen", "--lowvram", "--no-half", "--precision", "full", "--disable-safe-unpickle"]
