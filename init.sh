#!/bin/bash
set -e

echo "=== Установка моделей и LoRA ==="

# Папки
mkdir -p /workspace/ComfyUI/models/unet
mkdir -p /workspace/ComfyUI/models/vae
mkdir -p /workspace/ComfyUI/models/clip
mkdir -p /workspace/ComfyUI/models/loras
mkdir -p /workspace/ComfyUI/custom_nodes

# Instagirl v2.5
wget -nc -O /workspace/ComfyUI/models/loras/Instagirlv2.5-HIGH.safetensors \
"https://huggingface.co/dci05049/Test_Loras_Wan2.2/resolve/main/Instagirlv2.5-HIGH.safetensors"

wget -nc -O /workspace/ComfyUI/models/loras/Instagirlv2.5-LOW.safetensors \
"https://huggingface.co/dci05049/Test_Loras_Wan2.2/resolve/main/Instagirlv2.5-LOW.safetensors"

# Wan LoRA
wget -nc -O /workspace/ComfyUI/models/loras/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors \
"https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors"

# UNet модели
wget -nc -O /workspace/ComfyUI/models/unet/Wan2.2-T2V-A14B-LowNoise-Q8_0.gguf \
"https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2.2-T2V-A14B-LowNoise-Q8_0.gguf"

wget -nc -O /workspace/ComfyUI/models/unet/Wan2.2-T2V-A14B-HighNoise-Q8_0.gguf \
"https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2.2-T2V-A14B-HighNoise-Q8_0.gguf"

# VAE
wget -nc -O /workspace/ComfyUI/models/vae/wan_2.1_vae.safetensors \
"https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/wan_2.1_vae.safetensors"

# CLIP
wget -nc -O /workspace/ComfyUI/models/clip/umt5_xxl_fp8_e4m3fn_scaled.safetensors \
"https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
# LENOVO
wget -nc -O /workspace/ComfyUI/models/loras/Lenovo.safetensors \
"https://huggingface.co/Kulight/l3n0v0-lora/resolve/main/Lenovo.safetensors"

# Плагины
cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/city96/ComfyUI-GGUF.git || true
git clone https://github.com/Kosinkadink/ComfyUI-KJNodes.git || true
git clone https://github.com/pythongosssss/ComfyUI-Image-Saver.git || true

# Запуск ComfyUI на 8188
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188 &

# Пример: второй сервис (например, простой HTTP-сервер на 3001)
cd /workspace
python -m http.server 3001 --bind 0.0.0.0 &
 
# Ждём процессы
wait

