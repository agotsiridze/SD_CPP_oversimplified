/src/sd-server \
  --diffusion-model /workplace/models/base_models/flux-2-klein-9b-BF16.gguf \
  --llm /workplace/models/Qwen3-8B-Q6_K.gguf \
  --vae /workplace/models/vae/flux2_ae.safetensors \
  --lora-model-dir /workplace/models/upscale_loras \
  --listen-ip 0.0.0.0 \
  --listen-port "$PORT" \
  --backend cuda \
  --diffusion-fa \
  --eager-load
