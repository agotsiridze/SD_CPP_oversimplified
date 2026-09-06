/src/sd-server \
  --model /workplace/models/base_models/hidream_o1_image_bf16.safetensors \
  --listen-ip 0.0.0.0 \
  --listen-port 8080 \
  --backend cuda \
  --eager-load
