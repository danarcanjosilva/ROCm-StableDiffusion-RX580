# Stable Diffusion WebUI com ROCm em AMD RX 580 (GFX803)

Este repositório fornece um setup **funcional e testado** do **Stable Diffusion WebUI** rodando em **Docker** com **ROCm**, especificamente ajustado para **AMD RX 580 (GFX803)**.

> ⚠️ RX 580 **não é oficialmente suportada** pelas versões recentes do ROCm.  
> Este projeto existe justamente para contornar essas limitações e **fazer funcionar na prática**.

---

## 🖥️ Ambiente testado

- **GPU:** AMD Radeon RX 580 8GB (GFX803 / Polaris)
- **Sistema:** Ubuntu 20.04 / 22.04
- **Kernel:** 5.15.x
- **ROCm:** 6.1.2
- **PyTorch:** 2.4 (HIP)
- **Docker:** Engine + Compose
- **Imagem base:** `woodrex/rocm612-torch24-sd-webui-gfx803`

---

## 🚀 O que funciona

- ✅ Stable Diffusion WebUI (AUTOMATIC1111)
- ✅ Geração de imagens via GPU (HIP / ROCm)
- ✅ Atenção otimizada (`--opt-sdp-attention`)
- ✅ Modelos `.safetensors`
- ✅ Interface Web (porta 7860)

---

## ❌ Limitações conhecidas

- ❌ `xformers` não funciona em GFX803
- ❌ Algumas warnings do MIOpen (`hipMemGetInfo error`) — **não quebram a geração**
- ⚠️ Tempo de startup alto no primeiro boot (download + hash de modelos)
- ⚠️ Performance inferior a GPUs RDNA / NVIDIA (esperado)

---

## 📦 Estrutura do projeto

```text
.
├── Dockerfile
├── docker-compose.yml
├── webui-user.sh
├── cache/                # ignorado pelo git
├── models/               # ignorado pelo git
├── outputs/              # ignorado pelo git
└── stable-diffusion-webui/ (repositório externo, não versionado)
🔒 Modelos, outputs e cache não são enviados ao GitHub por segurança e tamanho.

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
2️⃣ Acessar no navegador
cpp
Copiar código
http://127.0.0.1:7860
⏹️ Parar / voltar depois
Parar o container
bash
Copiar código
sudo docker stop sd-webui
Iniciar novamente
bash
Copiar código
sudo docker start sd-webui
Logs em tempo real
bash
Copiar código
sudo docker logs -f sd-webui
🧪 Observações importantes
Não use --lowvram nem --no-half
→ causam travamentos ou geração infinita na RX 580

--opt-sdp-attention é obrigatório

HSA_OVERRIDE_GFX_VERSION=8.0.3 é essencial

O warning do MIOpen pode ser ignorado se a imagem gerar normalmente

🧠 Por que este projeto existe?
Muitos afirmam que:

“RX 580 não roda mais Stable Diffusion”

Este repositório prova que roda sim, com os ajustes corretos.

🤝 Créditos
AUTOMATIC1111 – Stable Diffusion WebUI

AMD ROCm Team

Comunidade open-source

Ajustes e testes: @danarcanjosilva

⚠️ Aviso legal
Use por sua conta e risco.
Este projeto não é afiliado oficialmente à AMD ou Stability AI.
