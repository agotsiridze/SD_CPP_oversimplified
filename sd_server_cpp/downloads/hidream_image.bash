set -euo pipefail
. /workplace/downloads/helpers.bash

download \
    "https://huggingface.co/Comfy-Org/HiDream-O1-Image/resolve/main/checkpoints/hidream_o1_image_bf16.safetensors" \
    "base_models/hidream_o1_image_bf16.safetensors" \
    8 &

wait

echo "All downloads finished."

