set -euo pipefail

. /workplace/downloads/helpers.bash

download \
    "https://huggingface.co/realrebelai/KREA-2_GGUFs/resolve/main/TURBO/Krea-2-Turbo-Q4_K_M.gguf" \
    "base_models/Krea-2-Turbo-Q4_K_M.gguf" \
    5 &

# download \
#     "https://huggingface.co/realrebelai/KREA-2_GGUFs/resolve/main/TURBO/Krea-2-Turbo-Q8_0.gguf" \
#     "base_models/Krea-2-Turbo-Q8_0.gguf" \
#     16 &

download \
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" \
    "vae/wan_2.1_vae.safetensors" \
    5 &

download \
    "https://huggingface.co/Qwen/Qwen3-VL-4B-Instruct-GGUF/resolve/main/Qwen3VL-4B-Instruct-F16.gguf" \
    "encoders/Qwen3VL-4B-Instruct-F16.gguf" \
    5 &

wait

echo "All downloads finished."
