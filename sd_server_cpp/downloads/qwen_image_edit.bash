set -euo pipefail

. /workplace/downloads/helpers.bash

download \
    "https://huggingface.co/unsloth/Qwen-Image-Edit-2511-GGUF/resolve/main/qwen-image-edit-2511-Q5_0.gguf" \
    "base_models/qwen-image-edit-2511-Q5_0.gguf" \
    8 &

download \
    "https://huggingface.co/mradermacher/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/Qwen2.5-VL-7B-Instruct.Q8_0.gguf" \
    "encoders/Qwen2.5-VL-7B-Instruct.Q8_0.gguf" \
    8 &

wait

echo "All downloads finished."

