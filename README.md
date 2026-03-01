markdown
# 🚀 Stable Diffusion WebUI para AMD RX580 (gfx803) com ROCm

<div align="center">
  <img src="https://img.shields.io/badge/ROCm-5.7-blueviolet" alt="ROCm Version">
  <img src="https://img.shields.io/badge/PyTorch-1.13.1-orange" alt="PyTorch Version">
  <img src="https://img.shields.io/badge/Status-Funcional-success" alt="Status">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
</div>

## 📋 Sobre o Projeto

Este repositório contém a configuração **100% funcional** do [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) rodando em **Docker** com suporte a **ROCm**, especificamente ajustado para placas **AMD RX580 (gfx803 / Polaris)**.

**✅ Status: TOTALMENTE FUNCIONAL!**

Após extensas correções manuais, a imagem já vem com **TUDO PRONTO** – basta baixar e executar.

---

## 🎯 Para Quem é Este Projeto?

- Usuários de **AMD RX580** que querem rodar Stable Diffusion sem dor de cabeça
- Quem já tentou e enfrentou erros como:
  - `stablediffusion.git` não encontrado
  - Erro ao instalar `clip`
  - Segmentation Fault ao testar GPU
  - Git pedindo usuário/senha

---

## 📦 Pré-requisitos no Host

| Requisito | Versão/Descrição |
|-----------|------------------|
| **Docker** | Instalado e funcionando |
| **Placa de vídeo** | AMD RX580 (gfx803) |
| **Drivers ROCm** | Versão 5.7 instalada no host |
| **Grupos** | Usuário nos grupos `video` e `render` |

---

## 🚀 Como Usar (Passo a Passo)

### 1. Clone o repositório (opcional)
```bash
git clone https://github.com/danarcanjosilva/ROCm-StableDiffusion-RX580.git
cd ROCm-StableDiffusion-RX580
2. Crie as pastas para modelos e imagens geradas
bash
mkdir -p models outputs
3. Baixe a imagem Docker pronta
bash
docker pull ghcr.io/danarcanjosilva/sd-rx580-completo:latest
4. Execute o container
bash
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
5. Acompanhe os logs (para saber quando iniciar)
bash
docker logs -f sd-rx580
Aguarde até aparecer:

text
Running on local URL:  http://0.0.0.0:7860
6. Acesse no navegador
text
http://localhost:7860
🛠️ Comandos Úteis para Gerenciar
Ação	Comando
Ver se o container está rodando	docker ps | grep sd-rx580
Ver logs em tempo real	docker logs -f sd-rx580
Parar o container	docker stop sd-rx580
Iniciar novamente	docker start sd-rx580
Entrar no container (se necessário)	docker exec -it sd-rx580 bash
Remover o container	docker rm sd-rx580
📂 Estrutura de Pastas
text
ROCm-StableDiffusion-RX580/
├── models/          # Coloque seus modelos .safetensors aqui
├── outputs/         # Imagens geradas serão salvas aqui
├── README.md        # Este arquivo
🧪 Teste Rápido
Assim que o WebUI abrir, faça um teste simples:

Campo	Valor
Prompt	beautiful landscape with mountains and river, sunset, photorealistic, 4k
Negative Prompt	ugly, blurry, bad quality, distorted
Steps	20
Sampler	DPM++ 2M
CFG Scale	7
Size	512x512
Clique em Generate e aguarde sua primeira imagem!

⚠️ Avisos Importantes (Podem ser Ignorados)
Durante a execução, você pode ver estes avisos – são normais e não afetam o funcionamento:

text
⚠️ Found no NVIDIA driver on your system
⚠️ no module 'xformers'
⚠️ Failed to load image Python extension
⚠️ Failed to resolve ldm.models.diffusion.ddpm.LatentDiffusion...
⚠️ Segmentation fault (core dumped) ao testar GPU
Todos esses avisos podem ser ignorados! A geração de imagens funciona perfeitamente.

🐛 Problemas Conhecidos e Soluções
Problema	Solução
Porta 7860 já em uso	Mude a porta: -p 7861:7860
Container não inicia	Verifique os drivers ROCm: rocm-smi
GPU não detectada	Confirme as variáveis: echo $HSA_OVERRIDE_GFX_VERSION
Modelos não aparecem	Coloque na pasta models/Stable-diffusion/
📊 Tamanhos e Recursos
Item	Tamanho
Imagem Docker	6.86 GB
Container em execução	~10.7 GB
RAM necessária	~5 GB
VRAM necessária	8 GB (RX580)
🔧 Correções Aplicadas na Imagem
Esta imagem já vem com TODAS as correções manuais aplicadas:

Problema Original	Solução Aplicada
Repositório stablediffusion.git não existe	Substituído por generative-models.git
Erro ao instalar clip	Instalação com --no-deps
Git fetch causando loop	Funções git desabilitadas
Módulo ldm não encontrado	Criado a partir de sgm
setuptools muito novo	Fixado na versão 69.5.1
Segmentation Fault ao testar GPU	Ignorado com --skip-torch-cuda-test
📚 Referências
Repositório Oficial do AUTOMATIC1111

Issue #17216 - Problema do repositório

Generative Models (Stability AI)

📄 Licença
Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

🤝 Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

⭐ Agradecimentos
Comunidade do Stable Diffusion

Mantenedores do ROCm

Todos que ajudaram nos testes e correções

✅ O QUE ESTE README INCLUI:
✅ Instruções passo a passo

✅ Comandos prontos para copiar e colar

✅ Explicação dos avisos (para não assustar os usuários)

✅ Tabela de problemas e soluções

✅ Detalhes técnicos (tamanhos, requisitos)

✅ Créditos e agradecimentos

