📝 ATUALIZAR O README DO SEU REPOSITÓRIO
Agora adicione estas instruções no README.md do seu repositório:

markdown
## 🐳 Imagem Docker Pronta

A imagem já está disponível no GitHub Container Registry:

```bash
# Baixar a imagem
docker pull ghcr.io/danarcanjosilva/sd-rx580-completo:latest

# Executar o container
docker run -d \
  --name sd-rx580 \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add video \
  --group-add render \
  -p 7860:7860 \
  -e HSA_OVERRIDE_GFX_VERSION=10.3.0 \
  -e COMMANDLINE_ARGS="--skip-torch-cuda-test --medvram --opt-sdp-attention --no-half-vae --precision full --no-half --listen" \
  -v $(pwd)/models:/app/stable-diffusion-webui/models \
  -v $(pwd)/outputs:/app/stable-diffusion-webui/outputs \
  ghcr.io/danarcanjosilva/sd-rx580-completo:latest
