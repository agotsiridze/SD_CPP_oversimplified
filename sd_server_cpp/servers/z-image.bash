/src/sd-server \
    --backend cuda \
    --diffusion-model /workplace/models/base_models/z_image_turbo-Q8_0.gguf \
    --llm /workplace/models/encoders/Qwen3-4B-Instruct-2507-F16.gguf \
    --vae /workplace/models/vae/ae.safetensors \
    --listen-ip 0.0.0.0 \
    --diffusion-fa \
    --listen-port "$PORT" \
    --eager-load
