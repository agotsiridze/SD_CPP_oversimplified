/src/sd-server \
    --diffusion-model /workplace/models/base_models/Krea-2-Turbo-Q8_0.gguf \
    --llm /workplace/models/encoders/Qwen3VL-4B-Instruct-F16.gguf \
    --vae /workplace/models/vae/wan_2.1_vae.safetensors \
    -v \
    --backend cuda \
    --eager-load \
    --listen-ip 0.0.0.0 \
    --listen-port "$PORT"

    # --diffusion-fa \


# /src/sd-server  \
#     --diffusion-model /workplace/models/base_models/Krea-2-Turbo-Q8_0.gguf \
#     --llm /workplace/models/encoders/Qwen3VL-4B-Instruct-F16.gguf \
#     --vae /workplace/models/vae/wan_2.1_vae.safetensors \
#     -p "a cat holding a sign that says test" \
#     --cfg-scale 1 \
#     --steps 8 \
#     --diffusion-fa \
#     -v
