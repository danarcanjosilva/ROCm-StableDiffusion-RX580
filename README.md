# Stable Diffusion WebUI com ROCm em AMD RX 580 (GFX803)

Este repositório fornece um setup **funcional e testado** do **Stable Diffusion WebUI (AUTOMATIC1111)** rodando em **Docker** com **ROCm**, especificamente ajustado para **AMD RX 580 (GFX803 / Polaris)**.

> ⚠️ **A RX 580 não é oficialmente suportada** pelas versões recentes do ROCm.  
> Este projeto existe justamente para contornar essas limitações e **fazer funcionar na prática**.

---

## 🖥️ Ambiente testado

- **GPU:** AMD Radeon RX 580 8GB (GFX803 / Polaris)
- **Sistema:** Ubuntu 20.04 / 22.04
- **Kernel:** 5.15.x
- **ROCm:** 6.1.2
- **PyTorch:** 2.4 (HIP)
- **Docker:** Docker Engine (+ Compose opcional)
- **Imagem base:** `woodrex/rocm612-torch24-sd-webui-gfx803`

---

## 📥 Clonar o repositório

```bash
git clone https://github.com/danarcanjosilva/ROCm-StableDiffusion-RX580.git
cd ROCm-StableDiffusion-RX580
🚀 O que funciona
✅ Stable Diffusion WebUI (AUTOMATIC1111)

✅ Geração de imagens via GPU (HIP / ROCm)

✅ Atenção otimizada (--opt-sdp-attention)

✅ Modelos .safetensors

✅ Interface Web via navegador (porta 7860)

❌ Limitações conhecidas
❌ xformers não funciona em GFX803

❌ Warnings do MIOpen (hipMemGetInfo error)
→ não quebram a geração

⚠️ Tempo de startup alto no primeiro boot
(download + hash dos modelos)

⚠️ Performance inferior a GPUs RDNA ou NVIDIA
(esperado para Polaris)

📦 Estrutura do projeto
text
Copiar código
.
├── Dockerfile
├── docker-compose.yml
├── webui-user.sh
├── cache/                  # ignorado pelo git
├── models/                 # ignorado pelo git
├── outputs/                # ignorado pelo git
└── stable-diffusion-webui/ # repositório externo (não versionado)
🔒 Modelos, outputs e cache não são enviados ao GitHub
por questões de tamanho, licença e segurança.

▶️ Como subir o container
1️⃣ Subir o Stable Diffusion WebUI
bash
Copiar código
sudo docker run -d \
  --name sd-webui \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add video \
  -p 7860:7860 \
  -e HSA_OVERRIDE_GFX_VERSION=8.0.3 \
  -e HIP_VISIBLE_DEVICES=0 \
  -e CUDA_VISIBLE_DEVICES=0 \
  -e PYTORCH_HIP_ALLOC_CONF=garbage_collection_threshold:0.8,max_split_size_mb:512 \
  --entrypoint python \
  woodrex/rocm612-torch24-sd-webui-gfx803 \
  launch.py --listen --opt-sdp-attention --skip-torch-cuda-test --disable-nan-check
⏱️ Primeira inicialização: pode levar vários minutos.

🌐 Acessar no navegador
cpp
Copiar código
http://127.0.0.1:7860
⏹️ Parar e iniciar novamente
Parar o container
bash
Copiar código
sudo docker stop sd-webui
Iniciar novamente
bash
Copiar código
sudo docker start sd-webui
Ver logs em tempo real
bash
Copiar código
sudo docker logs -f sd-webui
🧪 Observações importantes
❌ Não use --lowvram nem --no-half

✅ --opt-sdp-attention é obrigatório

✅ HSA_OVERRIDE_GFX_VERSION=8.0.3 é essencial

⚠️ Warnings do MIOpen podem ser ignorados se estiver gerando imagens

🧠 Por que este projeto existe?
Muitos afirmam:

“RX 580 não roda mais Stable Diffusion”

Este repositório prova que roda sim, com os ajustes corretos.

🤝 Créditos
AUTOMATIC1111 – Stable Diffusion WebUI

AMD ROCm Team

Comunidade open-source

Ajustes e testes: @danarcanjosilva

⚠️ Aviso legal
Use por sua conta e risco.
Este projeto não é afiliado oficialmente à AMD ou à Stability AI.
