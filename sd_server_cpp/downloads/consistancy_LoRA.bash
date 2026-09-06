set -euo pipefail
. /workplace/downloads/helpers.bash

download \
    "https://huggingface.co/dx8152/Flux2-Klein-9B-Consistency/resolve/main/Flux2-Klein-9B-consistency-V2.safetensors" \
    "upscale_loras/Flux2-Klein-9B-consistency-V2.safetensors" \
    16 &

wait

echo "All downloads finished."

